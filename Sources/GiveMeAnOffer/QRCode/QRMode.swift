//
//  QRMode.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/5.
//

import Foundation

struct QRBitBuffer {
    private(set) var buffer = [Int64]()
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
            put(bit: value)
        }
    }
    
    mutating func put(bit: Bool) {
        let buffIndex = Int(floor(Float(self.length) / 8))
        if buffer.count <= buffIndex {
            buffer.append(0)
        }
        if bit {
            buffer[buffIndex] |= Int64(0x80) >>> Int64(self.length % 8)
        }
        self.length += 1
    }
}

struct QR8BitByte {
    let data: String
    let mode: QRMode
    
    init(data: String) {
        self.data = data
        self.mode = QRMode.EightBit(data)
    }
    
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
    
    enum QRModeError: CustomNSError {
        static var errorDomain: String {
            return "com.daubert.qrCode.qrmode"
        }
        
        case type(Int)
        
        var errorCode: Int {
            return -103
        }
        
        var errorUserInfo: [String : Any] {
            switch self {
            case .type(let type):
                return [NSLocalizedDescriptionKey: "type: \(type)"]
            }
        }
    }
    
    var value: Int {
        switch self {
        case .Number: return 1 << 0
        case .AlphaNum: return 1 << 1
        case .EightBit: return 1 << 2
        case .Kanji: return 1 << 3
        }
    }
    
    func getLengthInBits(type: Int) throws -> Int {
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
            throw QRModeError.type(type)
        }
    }
}
