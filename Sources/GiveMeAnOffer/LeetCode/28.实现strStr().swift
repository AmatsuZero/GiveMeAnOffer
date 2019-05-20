//
// Created by daubert on 19-5-20.
//
/*
 * @lc app=leetcode.cn id=28 lang=swift
 *
 * [28] 实现strStr()
 *
 * https://leetcode-cn.com/problems/implement-strstr/description/
 *
 * algorithms
 * Easy (38.13%)
 * Likes:    192
 * Dislikes: 0
 * Total Accepted:    53.8K
 * Total Submissions: 141.1K
 * Testcase Example:  '"hello"\n"ll"'
 *
 * 实现 strStr() 函数。
 *
 * 给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置
 * (从0开始)。如果不存在，则返回  -1。
 *
 * 示例 1:
 *
 * 输入: haystack = "hello", needle = "ll"
 * 输出: 2
 *
 *
 * 示例 2:
 *
 * 输入: haystack = "aaaaa", needle = "bba"
 * 输出: -1
 *
 *
 * 说明:
 *
 * 当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。
 *
 * 对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与C语言的 strstr() 以及 Java的 indexOf() 定义相符。
 *
 */

import Foundation

extension String {
    func strStr(_ needle: String) -> Int {
        guard !needle.isEmpty else {
            return 0
        }
        guard !self.isEmpty, needle.count <= self.count else {
            return -1
        }

        let strs = self.map { String($0) }
        let Strs = needle.map { String($0) }

        for i in 0..<strs.count {
            guard strs.count - i >= Strs.count else {
                return -1
            }
            for j in 0..<Strs.count {
                if strs[i+j] != Strs[j] {
                    break
                }
                if j == Strs.count - 1 {
                    return i
                }
            }
        }
        return -1
    }
}