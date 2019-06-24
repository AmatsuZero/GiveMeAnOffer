//
//  414.第三大的数.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/24.
//
/*
 给定一个非空数组，返回此数组中第三大的数。如果不存在，则返回数组中最大的数。要求算法时间复杂度必须是O(n)。
 
 示例 1:
 
 输入: [3, 2, 1]
 
 输出: 1
 
 解释: 第三大的数是 1.
 示例 2:
 
 输入: [1, 2]
 
 输出: 2
 
 解释: 第三大的数不存在, 所以返回最大的数 2 .
 示例 3:
 
 输入: [2, 2, 3, 1]
 
 输出: 1
 
 解释: 注意，要求返回第三大的数，是指第三大且唯一出现的数。
 存在两个值为2的数，它们都排第二。
 */
import Foundation

public extension Array where Element: Comparable {
    
    func thirdMax() -> Element? {
        guard self.count >= 3 else {
            return self.count > 1 ? self.max() : self.first
        }
        
        var step = 1
        let sorted = self.sorted()
        for i in stride(from: count - 1, to: 0, by: -1) {
            if sorted[i] != sorted[i-1] {
                step += 1
            }
            if step == 3 {
                return sorted[i-1]
            }
        }
        return sorted[count-1]
    }
}
