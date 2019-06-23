//
//  70.爬楼梯.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/5/28.
//

import Foundation
/*
 给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。
 
 最高位数字存放在数组的首位， 数组中每个元素只存储一个数字。
 
 你可以假设除了整数 0 之外，这个整数不会以零开头。
 
 示例 1:
 
 输入: [1,2,3]
 输出: [1,2,4]
 解释: 输入数组表示数字 123。
 示例 2:
 
 输入: [4,3,2,1]
 输出: [4,3,2,2]
 解释: 输入数组表示数字 4321。
 */
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
