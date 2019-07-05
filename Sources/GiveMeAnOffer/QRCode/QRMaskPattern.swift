//
//  QRMaskPattern.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/5.
//

import Foundation

enum QRMaskPattern: Int, CaseIterable {
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
