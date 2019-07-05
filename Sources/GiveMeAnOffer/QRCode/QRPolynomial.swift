//
//  QRPolynomial.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/5.
//

import Foundation

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
    
    func multiply(_ e: QRPolynomial) throws -> QRPolynomial {
        var num = [Int](repeating: 0, count: self.length + e.length - 1)
        for i in 0..<self.length {
            for j in 0..<e.length {
                num[i + j] ^= (try self[i].glog() + (try e[j].glog())).gexp()
            }
        }
        return .init(num: num, shift: 0)
    }
    
    func mod(_ e: QRPolynomial) throws -> QRPolynomial {
        guard self.length - e.length >= 0 else {
            return self
        }
        
        var num = [Int](repeating: 0, count: self.length)
        let ratio = try self[0].glog() - (try e[0].glog())
        
        for i in 0..<self.length {
            num[i] = self[i]
        }
        
        for x in 0..<e.length {
            num[x] ^= (try e[x].glog() + ratio).gexp()
        }
        
        return try QRPolynomial(num: num, shift: 0).mod(e)
    }
    
    static func errorCorrectPolynomial(by errorCorrectLength: Int) throws -> QRPolynomial {
        var a = QRPolynomial(num: [1], shift: 0)
        for i in 0..<errorCorrectLength {
            a = try a.multiply(QRPolynomial(num: [1, i.gexp()], shift: 0))
        }
        return a
    }
}
