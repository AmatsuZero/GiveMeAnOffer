//
// Created by daubert on 19-6-12.
//
/*
 * @lc app=leetcode.cn id=53 lang=swift
 *
 * [53] 最大子序和
 *
 * https://leetcode-cn.com/problems/maximum-subarray/description/
 *
 * algorithms
 * Easy (44.95%)
 * Likes:    973
 * Dislikes: 0
 * Total Accepted:    61.7K
 * Total Submissions: 136K
 * Testcase Example:  '[-2,1,-3,4,-1,2,1,-5,4]'
 *
 * 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 *
 * 示例:
 *
 * 输入: [-2,1,-3,4,-1,2,1,-5,4],
 * 输出: 6
 * 解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
 *
 *
 * 进阶:
 *
 * 如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。
 *
 */

import Foundation

extension Array where Element == Int {
    public func maxSubArray() -> Int {
        guard self.count > 1 else {
            return self.reduce(0, { $0 + $1 })
        }
        var result = Array(repeating: 0, count: self.count)
        result[0] = self.first!
        var sum = self.first!
        for i in 1..<self.count {
            if result[i-1] > 0 {
                result[i] = result[i-1] + self[i]
            } else {
                result[i] = self[i]
            }
            sum = Swift.max(result[i], sum)
        }
        return sum
    }
}