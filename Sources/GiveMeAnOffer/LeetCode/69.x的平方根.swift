//
// Created by daubert on 19-6-14.
//
/*
 * @lc app=leetcode.cn id=69 lang=swift
 *
 * [69] x 的平方根
 *
 * https://leetcode-cn.com/problems/sqrtx/description/
 *
 * algorithms
 * Easy (35.82%)
 * Likes:    173
 * Dislikes: 0
 * Total Accepted:    37.7K
 * Total Submissions: 104.7K
 * Testcase Example:  '4'
 *
 * 实现 int sqrt(int x) 函数。
 *
 * 计算并返回 x 的平方根，其中 x 是非负整数。
 *
 * 由于返回类型是整数，结果只保留整数的部分，小数部分将被舍去。
 *
 * 示例 1:
 *
 * 输入: 4
 * 输出: 2
 *
 *
 * 示例 2:
 *
 * 输入: 8
 * 输出: 2
 * 说明: 8 的平方根是 2.82842...,
 * 由于返回类型是整数，小数部分将被舍去。
 *
 *
 */
import Foundation

extension Int {
    public func squareRoot() -> Int {
        guard self > 1 else {
            return self
        }
        var left = 0, right = self
        while left < right {
            let mid = left + (right - left) / 2
            if self / mid >= mid {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return  right - 1
    }
}