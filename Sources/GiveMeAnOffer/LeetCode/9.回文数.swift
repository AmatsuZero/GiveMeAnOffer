//
// Created by daubert on 19-5-26.
//
/*
 * @lc app=leetcode.cn id=9 lang=swift
 *
 * [9] 回文数
 *
 * https://leetcode-cn.com/problems/palindrome-number/description/
 *
 * algorithms
 * Easy (55.96%)
 * Likes:    602
 * Dislikes: 0
 * Total Accepted:    111.1K
 * Total Submissions: 198.3K
 * Testcase Example:  '121'
 *
 * 判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
 *
 * 示例 1:
 *
 * 输入: 121
 * 输出: true
 *
 *
 * 示例 2:
 *
 * 输入: -121
 * 输出: false
 * 解释: 从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
 *
 *
 * 示例 3:
 *
 * 输入: 10
 * 输出: false
 * 解释: 从右向左读, 为 01 。因此它不是一个回文数。
 *
 *
 * 进阶:
 *
 * 你能不将整数转为字符串来解决这个问题吗？
 *
 */
import Foundation

extension Int {
    var isPalindrome: Bool {
        guard self >= 0 else {
            return false
        }
        var digits = [Int]()
        var mirror = self
        while mirror != 0 {
            digits.append(mirror % 10)
            mirror /= 10
        }
        return digits.reduce(0, { x, y in
            x * 10 + y
        }) == self
    }
}