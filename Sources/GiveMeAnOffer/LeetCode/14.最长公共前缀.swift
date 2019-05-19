//
// Created by daubert on 19-5-19.
//

/*
 * @lc app=leetcode.cn id=14 lang=swift
 *
 * [14] 最长公共前缀
 *
 * https://leetcode-cn.com/problems/longest-common-prefix/description/
 *
 * algorithms
 * Easy (33.31%)
 * Likes:    550
 * Dislikes: 0
 * Total Accepted:    80.4K
 * Total Submissions: 241.4K
 * Testcase Example:  '["flower","flow","flight"]'
 *
 * 编写一个函数来查找字符串数组中的最长公共前缀。
 *
 * 如果不存在公共前缀，返回空字符串 ""。
 *
 * 示例 1:
 *
 * 输入: ["flower","flow","flight"]
 * 输出: "fl"
 *
 *
 * 示例 2:
 *
 * 输入: ["dog","racecar","car"]
 * 输出: ""
 * 解释: 输入不存在公共前缀。
 *
 *
 * 说明:
 *
 * 所有输入只包含小写字母 a-z 。
 *
 */

extension Array where Element == String {
    public func longestCommonPrefix() -> String {
        var prefix = self.min(by: {$0.count < $1.count}) ?? ""
        while prefix.count > 0 {
            if allSatisfy({ $0.hasPrefix(prefix) }) {
                break
            }
            let endIndex = prefix.index(before: prefix.endIndex)
            prefix = String(prefix[..<endIndex])
        }
        return prefix
    }
}


