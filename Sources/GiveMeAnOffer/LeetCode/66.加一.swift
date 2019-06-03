//
//  70.爬楼梯.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/5/28.
//

import Foundation

extension Array where Element == Int {
    public func plusOne() -> [Element] {
        var index = count - 1
        var copy = [Element](self)
        while index >= 0 {
            if copy[index] < 9 {
                copy[index] += 1
                return copy
            } else {
                copy[index] = 0
                index -= 1
            }
        }
        copy = Array(repeating: 0, count: self.count + 1)
        copy[0] = 1
        return copy
    }
}
