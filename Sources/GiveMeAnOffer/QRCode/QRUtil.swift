//
//  QRUtil.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/5.
//

import Foundation

infix operator >>> : BitwiseShiftPrecedence

func >>> (lhs: Int64, rhs: Int64) -> Int64 {
    return Int64(bitPattern: UInt64(bitPattern: lhs) >> UInt64(rhs))
}

extension Int {
    
    enum QRMathError: CustomNSError {
        
        static var errorDomain: String {
            return "com.daubert.qrCode.qrmath"
        }
        
        case glog(Int)
        
        var errorCode: Int {
            switch self {
            case .glog: return -102
            }
        }
        
        var errorUserInfo: [String : Any] {
            switch self {
            case .glog(let n):
                return [NSLocalizedDescriptionKey: "glog(\(n))"]
            }
        }
        
    }
    
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
    
    private static let PATTERN_POSITION_TABLE: [[Int]] = {
        return [
            [],
            [6, 18],
            [6, 22],
            [6, 26],
            [6, 30],
            [6, 34],
            [6, 22, 38],
            [6, 24, 42],
            [6, 26, 46],
            [6, 28, 50],
            [6, 30, 54],
            [6, 32, 58],
            [6, 34, 62],
            [6, 26, 46, 66],
            [6, 26, 48, 70],
            [6, 26, 50, 74],
            [6, 30, 54, 78],
            [6, 30, 56, 82],
            [6, 30, 58, 86],
            [6, 34, 62, 90],
            [6, 28, 50, 72, 94],
            [6, 26, 50, 74, 98],
            [6, 30, 54, 78, 102],
            [6, 28, 54, 80, 106],
            [6, 32, 58, 84, 110],
            [6, 30, 58, 86, 114],
            [6, 34, 62, 90, 118],
            [6, 26, 50, 74, 98, 122],
            [6, 30, 54, 78, 102, 126],
            [6, 26, 52, 78, 104, 130],
            [6, 30, 56, 82, 108, 134],
            [6, 34, 60, 86, 112, 138],
            [6, 30, 58, 86, 114, 142],
            [6, 34, 62, 90, 118, 146],
            [6, 30, 54, 78, 102, 126, 150],
            [6, 24, 50, 76, 102, 128, 154],
            [6, 28, 54, 80, 106, 132, 158],
            [6, 32, 58, 84, 110, 136, 162],
            [6, 26, 54, 82, 110, 138, 166],
            [6, 30, 58, 86, 114, 142, 170]
        ]
    }()
    
    func glog() throws -> Int {
        guard self >= 1 else {
            throw QRMathError.glog(self)
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
    
    func bchDigit() -> Int {
        var digit = 0
        var data = self
        while data != 0 {
            digit += 1
            data = Int(Int64(data) >>> 1)
        }
        return digit
    }
    
    private static let G15: Int = {
        var value = 1 << 10
        value |= (1 << 8)
        value |= (1 << 5)
        value |= (1 << 4)
        value |= (1 << 2)
        value |= (1 << 1)
        value |= (1 << 0)
        return value
    }()
    
    private static let G18: Int = {
        var value = 1 << 12
        value |= (1 << 11)
        value |= (1 << 10)
        value |= (1 << 9)
        value |= (1 << 8)
        value |= (1 << 5)
        value |= (1 << 2)
        value |= (1 << 0)
        return value
    }()
    
    private static let G15_MASK: Int = {
        var value = 1 << 14
        value |= (1 << 12)
        value |= (1 << 10)
        value |= (1 << 4)
        value |= (1 << 1)
        return value
    }()
    
    func bchTypeInfo() -> Int {
        var d = self << 10
        while d.bchDigit() - Int.G15.bchDigit() > 0 {
            d ^= (Int.G15 << (d.bchDigit() - Int.G15.bchDigit()))
        }
        return self << 12 | d
    }
    
    func bchTypeNumber() -> Int {
        var d = self << 12
        while d.bchDigit() - Int.G18.bchDigit() >= 0 {
            d ^= (Int.G18 << (d.bchDigit() - Int.G18.bchDigit()))
        }
        return (d << 12) | d
    }
    
    func patterPosition() -> [Int] {
        guard self > 0, self < Int.PATTERN_POSITION_TABLE.count else {
            return []
        }
        return Int.PATTERN_POSITION_TABLE[self-1]
    }
}

extension Character  {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}

enum QRPlatte: String {
    case WHITE_ALL = "\u{2588}"
    case WHITE_BLACK = "\u{2580}"
    case BLACK_WHITE = "\u{2584}"
    case BLACK_ALL = " "
    
    func times(_ n: Int) -> String {
        return [String](repeating: rawValue, count: n - 1).joined()
    }
}

enum QRBlockColor: String {
    case black = "\033[40m  \033[0m"
    case white = "\033[47m  \033[0m"
    
    func fill(_ length: Int) -> [String] {
        return [String](repeating: rawValue, count: length)
    }
    
    func times(_ n: Int) -> String {
        return [String](repeating: rawValue, count: n - 1).joined()
    }
}

extension String {
    
    public func generateQR(isSmall: Bool, errorCorrectLevel: QRErrorCorrectLevel = .L) throws -> String {
        
        let qrCode = QRCode(type: -1, errorCorrectLevel: errorCorrectLevel)
        qrCode.add(data: self)
        try qrCode.make()
        
        var output = ""
        if isSmall {
            let BLACK = true,
            WHITE = false
            
            let moduleCount = qrCode.moduleCount
            var moduleData = qrCode.modules
            
            let oddRow = moduleCount % 2 == 1
            if oddRow {
                moduleData.append([Bool](repeating: WHITE, count: moduleCount))
            }
            
            let borderTop = QRPlatte.BLACK_WHITE.times(moduleCount + 3)
            let boderBottom = QRPlatte.WHITE_BLACK.times(moduleCount + 3)
            
            output += borderTop + "\n"
            
            for row in stride(from: 0, to: moduleCount, by: 2) {
                output += QRPlatte.WHITE_ALL.rawValue
                for col in 0..<moduleCount {
                    if moduleData[row][col] == WHITE, moduleData[row+1][col] == WHITE {
                        output += QRPlatte.WHITE_ALL.rawValue
                    } else if moduleData[row][col] == WHITE, moduleData[row+1][col] == BLACK {
                        output += QRPlatte.WHITE_BLACK.rawValue
                    } else if moduleData[row][col] == BLACK, moduleData[row+1][col] == WHITE {
                        output += QRPlatte.BLACK_WHITE.rawValue
                    } else {
                        output += QRPlatte.BLACK_ALL.rawValue
                    }
                }
                output += QRPlatte.WHITE_ALL.rawValue + "\n"
            }
            
            if !oddRow {
                output += boderBottom
            }
        } else {
            let border = QRBlockColor.white.times(qrCode.moduleCount + 3)
            output += border + "\n"
            qrCode.modules.forEach { row in
                output += QRBlockColor.white.rawValue
                output += row.map { $0 ?? false ? QRBlockColor.black.rawValue : QRBlockColor.white.rawValue }.joined()
                output += QRBlockColor.white.rawValue + "\n"
            }
            output += border
        }

        return output
    }
}
