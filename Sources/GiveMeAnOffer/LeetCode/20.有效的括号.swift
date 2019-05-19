//
// Created by daubert on 19-5-19.
//
/*
 * @lc app=leetcode.cn id=20 lang=swift
 *
 * [20] 有效的括号
 *
 * https://leetcode-cn.com/problems/valid-parentheses/description/
 *
 * algorithms
 * Easy (38.08%)
 * Likes:    804
 * Dislikes: 0
 * Total Accepted:    75K
 * Total Submissions: 197.1K
 * Testcase Example:  '"()"'
 *
 * 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
 *
 * 有效字符串需满足：
 *
 *
 * 左括号必须用相同类型的右括号闭合。
 * 左括号必须以正确的顺序闭合。
 *
 *
 * 注意空字符串可被认为是有效字符串。
 *
 * 示例 1:
 *
 * 输入: "()"
 * 输出: true
 *
 *
 * 示例 2:
 *
 * 输入: "()[]{}"
 * 输出: true
 *
 *
 * 示例 3:
 *
 * 输入: "(]"
 * 输出: false
 *
 *
 * 示例 4:
 *
 * 输入: "([)]"
 * 输出: false
 *
 *
 * 示例 5:
 *
 * 输入: "{[]}"
 * 输出: true
 *
 */

import Foundation

extension String {
    public func isValidParenthesisPair() -> Bool {
        let leftBrackets: [Character] = ["(", "{", "["]
        let rightBrackets: [Character] = [")", "}", "]"]
        var records = [Character]()
        for char in  self {
            if leftBrackets.contains(char) {
                records.append(char)
            } else if let index = rightBrackets.firstIndex(of: char) {
                guard let lastRecord = records.popLast(),
                      let idx = leftBrackets.firstIndex(of: lastRecord),
                      idx == index else {
                     return false
                }
            }
        }
        // 便利之后，记录应该为空
        return records.isEmpty
    }
}