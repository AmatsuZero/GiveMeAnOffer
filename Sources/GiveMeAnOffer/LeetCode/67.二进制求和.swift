//
//  67.二进制求和.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/5/31.
//

import Foundation

extension Int {
    public var binaryExpression: String {
        var exp = ""
        var digit = self
        while digit > 0 {
            exp.insert(Character("\(digit % 2)"), at: exp.startIndex)
            digit /= 2
        }
        return exp
    }
}

extension String {
    mutating public func addBinary(_ b: String) {
        var res = "",
        ia = self.count - 1,
        ib = b.count - 1,
        c = 0
        while (ia >= 0 || ib >= 0 || c > 0) {
            
            let ad = (ia >= 0) ? Int(String(self[self.index(self.startIndex, offsetBy: ia)])) : 0
            let bd = (ib >= 0) ? Int(String(b[b.index(b.startIndex, offsetBy: ib)])) : 0
            
            let sum = ad! + bd! + c
            c = (sum >= 2) ? 1 : 0
            
            res = "\(sum % 2)" + res
            
            ia -= 1
            ib -= 1
        }
        self = res
    }
    
    public func addBinary(_ b: String) -> String {
        var res = "",
        ia = self.count - 1,
        ib = b.count - 1,
        c = 0
        while (ia >= 0 || ib >= 0 || c > 0) {
            
            let ad = (ia >= 0) ? Int(String(self[self.index(self.startIndex, offsetBy: ia)])) : 0
            let bd = (ib >= 0) ? Int(String(b[b.index(b.startIndex, offsetBy: ib)])) : 0
            
            let sum = ad! + bd! + c
            c = (sum >= 2) ? 1 : 0
            
            res = "\(sum % 2)" + res
            
            ia -= 1
            ib -= 1
        }
        return res
    }
}
