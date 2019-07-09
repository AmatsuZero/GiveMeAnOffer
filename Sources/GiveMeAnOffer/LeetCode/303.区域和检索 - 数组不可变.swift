//
//  303.区域和检索 - 数组不可变.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/9.
//
/*
 给定一个整数数组  nums，求出数组从索引 i 到 j  (i ≤ j) 范围内元素的总和，包含 i,  j 两点。
 
 示例：
 
 给定 nums = [-2, 0, 3, -5, 2, -1]，求和函数为 sumRange()
 
 sumRange(0, 2) -> 1
 sumRange(2, 5) -> -1
 sumRange(0, 5) -> -3
 说明:
 
 你可以假设数组不可变。
 会多次调用 sumRange 方法。
 */
import Foundation

public struct NumArray {
    
    private var sums: [Int]
    
    public init(_ nums: [Int]) {
        sums = [Int](repeating: 0, count: nums.count)
        guard !nums.isEmpty else {
            return
        }
        sums[0] = nums[0]
        for i in 1..<nums.count {
            sums[i] = sums[i - 1] + nums[i]
        }
    }
    
    public func sumRange(_ range: Range<Int>) -> Int {
        if range.lowerBound == 0 {
            return sums[range.upperBound]
        } else {
            return sums[range.upperBound] - sums[range.lowerBound - 1]
        }
    }
}
