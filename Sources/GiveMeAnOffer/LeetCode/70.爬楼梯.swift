//
// Created by daubert on 19-6-2.
//
/*
 * @lc app=leetcode.cn id=70 lang=swift
 *
 * [70] 爬楼梯
 *
 * https://leetcode-cn.com/problems/climbing-stairs/description/
 *
 * algorithms
 * Easy (45.28%)
 * Likes:    490
 * Dislikes: 0
 * Total Accepted:    49.9K
 * Total Submissions: 109.8K
 * Testcase Example:  '2'
 *
 * 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
 *
 * 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
 *
 * 注意：给定 n 是一个正整数。
 *
 * 示例 1：
 *
 * 输入： 2
 * 输出： 2
 * 解释： 有两种方法可以爬到楼顶。
 * 1.  1 阶 + 1 阶
 * 2.  2 阶
 *
 * 示例 2：
 *
 * 输入： 3
 * 输出： 3
 * 解释： 有三种方法可以爬到楼顶。
 * 1.  1 阶 + 1 阶 + 1 阶
 * 2.  1 阶 + 2 阶
 * 3.  2 阶 + 1 阶
 *
 *
 */

import Foundation

extension Int {
    public func climbStairs() -> Int {
        guard self >= 4 else {
            return self
        }

        var oneStep = 1
        var twoStep = 1
        var total = 0

        for _ in 1..<self {
            total = oneStep + twoStep
            oneStep = twoStep
            twoStep = total
        }

        return total
    }
}