//
// Created by daubert on 19-7-4.
//

import Foundation

infix operator >>> : BitwiseShiftPrecedence

func >>> (lhs: Int64, rhs: Int64) -> Int64 {
    return Int64(bitPattern: UInt64(bitPattern: lhs) >> UInt64(rhs))
}

extension Int {
    private static var EXP: [Int] = {
        var table = [Int](repeating: 0, count: 256)
        for i in 0..<8 {
            table[i] = 1 << i
        }
        for i in 8..<256 {
            table[i] = table[i - 4]
                    ^ table[i - 5]
                    ^ table[i - 6]
                    ^ table[i - 8]
        }
        return table
    }()

    private static var LOG: [Int] = {
        var table = [Int](repeating: 0, count: 256)
        for i in 0..<255 {
            table[EXP[i]] = i
        }
        return table
    }()

    func glog() -> Int? {
        guard self >= 1 else {
            return nil
        }
        return Int.LOG[self]
    }

    func gexp() -> Int {
        var n = self
        while n < 0 {
            n += 255
        }

        while n >= 256 {
            n -= 255
        }

        return Int.EXP[n]
    }
}

struct QRBitBuffer {
    private var buffer = [Int64]()
    private(set) var length: Int = 0

    subscript(index: Int) -> Bool {
        get {
            let buffIndex = Int(floor(Float(index) / 8))
            return ((Int64(buffer[buffIndex]) >>> Int64(7 - index % 8)) & 1) == 1
        }
    }

    mutating func put(num: Int, length: Int) {
        for i in 0..<length {
            let value = ((Int64(num) >>> Int64(length - i - 1)) & 1) == 1
            put(bit: value ? 1 : 0)
        }
    }

    mutating func put(bit: Int) {
        let buffIndex = Int(floor(Float(self.length) / 8))
        if buffer.count <= buffIndex {
            buffer.append(0)
        }
        if bit != 0 {
            buffer[buffIndex] |= Int64(0x80) >>> Int64(self.length % 8)
        }
        self.length += 1
    }
}

struct QR8BitByte {
    let data: String
    let mode = QRMode.EightBit

    var length: Int {
        return data.count
    }

    func write(buffer: inout QRBitBuffer) {
        data.map { Int($0.unicodeScalarCodePoint()) }
                .forEach { buffer.put(num: $0, length: 8)}
    }
}

enum QRMode {
    case Number
    case AlphaNum
    case EightBit(String)
    case Kanji

    func getLengthInBits(type: Int) -> Int? {
        switch type {
        case 1..<10:
            switch self {
            case .Number: return 10
            case .AlphaNum: return 9
            case .EightBit, .Kanji: return 8
            }
        case 10..<27:
            switch self {
            case .Number: return 12
            case .AlphaNum: return 11
            case .EightBit: return 16
            case .Kanji: return 10
            }
        case 27..<41:
            switch self {
            case .Number: return 14
            case .AlphaNum: return 13
            case .EightBit: return 16
            case .Kanji: return 12
            }
        default:
            return nil
        }
    }
}

extension Character  {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}

struct QRPolynomial {
    private var num: [Int]

    var length: Int {
        return num.count
    }

    init(num: [Int], shift: Int) {
        var offset = 0
        while offset < num.count, num[offset] == 0 {
            offset += 1
        }
        self.num = [Int](repeating: 0, count: num.count - offset + shift)
        for i in 0..<(num.count - offset) {
            self.num[i] = num[i + offset]
        }
    }

    subscript(index: Int) -> Int {
        get {
            return num[index]
        }
    }

    func multiply(_ e: QRPolynomial) -> QRPolynomial {
        var num = [Int](repeating: 0, count: self.length - e.length - 1)
        for i in 0..<self.length {
            for j in 0..<e.length {
                num[i + j] ^= (self[i].glog()! + e[j].glog()!).gexp()
            }
        }
        return .init(num: num, shift: 0)
    }

    func mod(_ e: QRPolynomial) -> QRPolynomial {
        guard self.length - e.length >= 0 else {
            return self
        }

        var num = [Int](repeating: self.length, count: 0)
        let ratio = self[0].glog()! - e[0].glog()!

        for i in 0..<self.length {
            num[i] = self[i]
        }
        
        for x in 0..<e.length {
            num[x] ^= (e[x].glog()! + ratio).gexp()
        }

        return QRPolynomial(num: num, shift: 0).mod(e)
    }
    
    static func errorCorrectPolynomial(by errorCorrectLength: Int) -> QRPolynomial {
        var a = QRPolynomial(num: [1], shift: 0)
        for i in 0..<errorCorrectLength {
            a = a.multiply(QRPolynomial(num: [1, i.gexp()], shift: 0))
        }
        return a
    }
}

struct QRRSBlock {
    var totalCount: Int
    var dataCount: Int
}

enum QRErrorCorrectLevel: Int {
    case M = 0, L, H, Q
    private static var RS_BLOCK: [[Int]] = {
        return [
            // L
            // M
            // Q
            // H

            // 1
            [1, 26, 19],
            [1, 26, 16],
            [1, 26, 13],
            [1, 26, 9],

            // 2
            [1, 44, 34],
            [1, 44, 28],
            [1, 44, 22],
            [1, 44, 16],

            // 3
            [1, 70, 55],
            [1, 70, 44],
            [2, 35, 17],
            [2, 35, 13],

            // 4
            [1, 100, 80],
            [2, 50, 32],
            [2, 50, 24],
            [4, 25, 9],

            // 5
            [1, 134, 108],
            [2, 67, 43],
            [2, 33, 15, 2, 34, 16],
            [2, 33, 11, 2, 34, 12],

            // 6
            [2, 86, 68],
            [4, 43, 27],
            [4, 43, 19],
            [4, 43, 15],

            // 7
            [2, 98, 78],
            [4, 49, 31],
            [2, 32, 14, 4, 33, 15],
            [4, 39, 13, 1, 40, 14],

            // 8
            [2, 121, 97],
            [2, 60, 38, 2, 61, 39],
            [4, 40, 18, 2, 41, 19],
            [4, 40, 14, 2, 41, 15],

            // 9
            [2, 146, 116],
            [3, 58, 36, 2, 59, 37],
            [4, 36, 16, 4, 37, 17],
            [4, 36, 12, 4, 37, 13],

            // 10
            [2, 86, 68, 2, 87, 69],
            [4, 69, 43, 1, 70, 44],
            [6, 43, 19, 2, 44, 20],
            [6, 43, 15, 2, 44, 16],

            // 11
            [4, 101, 81],
            [1, 80, 50, 4, 81, 51],
            [4, 50, 22, 4, 51, 23],
            [3, 36, 12, 8, 37, 13],

            // 12
            [2, 116, 92, 2, 117, 93],
            [6, 58, 36, 2, 59, 37],
            [4, 46, 20, 6, 47, 21],
            [7, 42, 14, 4, 43, 15],

            // 13
            [4, 133, 107],
            [8, 59, 37, 1, 60, 38],
            [8, 44, 20, 4, 45, 21],
            [12, 33, 11, 4, 34, 12],

            // 14
            [3, 145, 115, 1, 146, 116],
            [4, 64, 40, 5, 65, 41],
            [11, 36, 16, 5, 37, 17],
            [11, 36, 12, 5, 37, 13],

            // 15
            [5, 109, 87, 1, 110, 88],
            [5, 65, 41, 5, 66, 42],
            [5, 54, 24, 7, 55, 25],
            [11, 36, 12],

            // 16
            [5, 122, 98, 1, 123, 99],
            [7, 73, 45, 3, 74, 46],
            [15, 43, 19, 2, 44, 20],
            [3, 45, 15, 13, 46, 16],

            // 17
            [1, 135, 107, 5, 136, 108],
            [10, 74, 46, 1, 75, 47],
            [1, 50, 22, 15, 51, 23],
            [2, 42, 14, 17, 43, 15],

            // 18
            [5, 150, 120, 1, 151, 121],
            [9, 69, 43, 4, 70, 44],
            [17, 50, 22, 1, 51, 23],
            [2, 42, 14, 19, 43, 15],

            // 19
            [3, 141, 113, 4, 142, 114],
            [3, 70, 44, 11, 71, 45],
            [17, 47, 21, 4, 48, 22],
            [9, 39, 13, 16, 40, 14],

            // 20
            [3, 135, 107, 5, 136, 108],
            [3, 67, 41, 13, 68, 42],
            [15, 54, 24, 5, 55, 25],
            [15, 43, 15, 10, 44, 16],

            // 21
            [4, 144, 116, 4, 145, 117],
            [17, 68, 42],
            [17, 50, 22, 6, 51, 23],
            [19, 46, 16, 6, 47, 17],

            // 22
            [2, 139, 111, 7, 140, 112],
            [17, 74, 46],
            [7, 54, 24, 16, 55, 25],
            [34, 37, 13],

            // 23
            [4, 151, 121, 5, 152, 122],
            [4, 75, 47, 14, 76, 48],
            [11, 54, 24, 14, 55, 25],
            [16, 45, 15, 14, 46, 16],

            // 24
            [6, 147, 117, 4, 148, 118],
            [6, 73, 45, 14, 74, 46],
            [11, 54, 24, 16, 55, 25],
            [30, 46, 16, 2, 47, 17],

            // 25
            [8, 132, 106, 4, 133, 107],
            [8, 75, 47, 13, 76, 48],
            [7, 54, 24, 22, 55, 25],
            [22, 45, 15, 13, 46, 16],

            // 26
            [10, 142, 114, 2, 143, 115],
            [19, 74, 46, 4, 75, 47],
            [28, 50, 22, 6, 51, 23],
            [33, 46, 16, 4, 47, 17],

            // 27
            [8, 152, 122, 4, 153, 123],
            [22, 73, 45, 3, 74, 46],
            [8, 53, 23, 26, 54, 24],
            [12, 45, 15, 28, 46, 16],

            // 28
            [3, 147, 117, 10, 148, 118],
            [3, 73, 45, 23, 74, 46],
            [4, 54, 24, 31, 55, 25],
            [11, 45, 15, 31, 46, 16],

            // 29
            [7, 146, 116, 7, 147, 117],
            [21, 73, 45, 7, 74, 46],
            [1, 53, 23, 37, 54, 24],
            [19, 45, 15, 26, 46, 16],

            // 30
            [5, 145, 115, 10, 146, 116],
            [19, 75, 47, 10, 76, 48],
            [15, 54, 24, 25, 55, 25],
            [23, 45, 15, 25, 46, 16],

            // 31
            [13, 145, 115, 3, 146, 116],
            [2, 74, 46, 29, 75, 47],
            [42, 54, 24, 1, 55, 25],
            [23, 45, 15, 28, 46, 16],

            // 32
            [17, 145, 115],
            [10, 74, 46, 23, 75, 47],
            [10, 54, 24, 35, 55, 25],
            [19, 45, 15, 35, 46, 16],

            // 33
            [17, 145, 115, 1, 146, 116],
            [14, 74, 46, 21, 75, 47],
            [29, 54, 24, 19, 55, 25],
            [11, 45, 15, 46, 46, 16],

            // 34
            [13, 145, 115, 6, 146, 116],
            [14, 74, 46, 23, 75, 47],
            [44, 54, 24, 7, 55, 25],
            [59, 46, 16, 1, 47, 17],

            // 35
            [12, 151, 121, 7, 152, 122],
            [12, 75, 47, 26, 76, 48],
            [39, 54, 24, 14, 55, 25],
            [22, 45, 15, 41, 46, 16],

            // 36
            [6, 151, 121, 14, 152, 122],
            [6, 75, 47, 34, 76, 48],
            [46, 54, 24, 10, 55, 25],
            [2, 45, 15, 64, 46, 16],

            // 37
            [17, 152, 122, 4, 153, 123],
            [29, 74, 46, 14, 75, 47],
            [49, 54, 24, 10, 55, 25],
            [24, 45, 15, 46, 46, 16],

            // 38
            [4, 152, 122, 18, 153, 123],
            [13, 74, 46, 32, 75, 47],
            [48, 54, 24, 14, 55, 25],
            [42, 45, 15, 32, 46, 16],

            // 39
            [20, 147, 117, 4, 148, 118],
            [40, 75, 47, 7, 76, 48],
            [43, 54, 24, 22, 55, 25],
            [10, 45, 15, 67, 46, 16],

            // 40
            [19, 148, 118, 6, 149, 119],
            [18, 75, 47, 31, 76, 48],
            [34, 54, 24, 34, 55, 25],
            [20, 45, 15, 61, 46, 16]
        ]
    }()

    func rsBlockTable(type: Int) -> [Int] {
        switch self {
        case .L:
            return QRErrorCorrectLevel.RS_BLOCK[(type - 1) * 4 + 0]
        case .M:
            return QRErrorCorrectLevel.RS_BLOCK[(type - 1) * 4 + 1]
        case .Q:
            return QRErrorCorrectLevel.RS_BLOCK[(type - 1) * 4 + 2]
        case .H:
            return QRErrorCorrectLevel.RS_BLOCK[(type - 1) * 4 + 3]
        }
    }

    func rsBlocks(type: Int) -> [QRRSBlock] {
        let rsBlock = rsBlockTable(type: type)

        var list = [QRRSBlock]()

        for i in 0..<rsBlock.count / 3 {
            let count = rsBlock[i * 3 + 0]
            let totalCount = rsBlock[i * 3 + 1]
            let dataCount = rsBlock[i * 3 + 2]
            for _ in 0..<count {
                list.append(.init(totalCount: totalCount, dataCount: dataCount))
            }
        }
        return list
    }
}

enum QRMaskPattern: Int {
    case PATTERN000 = 0, PATTERN001, PATTERN010, PATTERN011
    case PATTERN100, PATTERN101, PATTERN110, PATTERN111

    func getMask(_ i: Int, _ j: Int) -> Bool {
        switch self {
        case .PATTERN000: return (i + j) % 2 == 0
        case .PATTERN001: return i % 2  == 0
        case .PATTERN010: return j % 3 == 0
        case .PATTERN011: return (i + j) % 3 == 0
        case .PATTERN100:
            return (Int(floor(Float(i / 2))) + Int(floor(Float(j / 3)))) % 2 == 0
        case .PATTERN101: return (i * j) % 2 + (i * j) % 3 == 0
        case .PATTERN110: return ((i * j) % 2 + (i * j) % 3) % 2 == 0
        case .PATTERN111: return ((i * j) % 3 + (i + j) % 2) % 2 == 0
        }
    }
}

struct QRCode {

}