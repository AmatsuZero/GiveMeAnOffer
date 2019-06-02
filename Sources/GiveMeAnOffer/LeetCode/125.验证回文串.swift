//
// Created by daubert on 19-5-26.
//
/*
 * @lc app=leetcode.cn id=125 lang=swift
 *
 * [125] 验证回文串
 *
 * https://leetcode-cn.com/problems/valid-palindrome/description/
 *
 * algorithms
 * Easy (39.57%)
 * Likes:    87
 * Dislikes: 0
 * Total Accepted:    36.7K
 * Total Submissions: 92.5K
 * Testcase Example:  '"A man, a plan, a canal: Panama"'
 *
 * 给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
 *
 * 说明：本题中，我们将空字符串定义为有效的回文串。
 *
 * 示例 1:
 *
 * 输入: "A man, a plan, a canal: Panama"
 * 输出: true
 *
 *
 * 示例 2:
 *
 * 输入: "race a car"
 * 输出: false
 *
 *
 */

import Foundation

extension String {
    public var isPalindrome: Bool {
        if isEmpty {
            return true
        }
        let characters = Array(lowercased().unicodeScalars)
        let alphanumericsSet = CharacterSet.alphanumerics
        var left = 0
        var right = unicodeScalars.count - 1
        var leftCharacter = characters[left]
        var rightCharacter = characters[right]

        while left <= right {
            leftCharacter = characters[left]
            rightCharacter = characters[right]
            while left < right, !alphanumericsSet.contains(leftCharacter) {
                left += 1
                leftCharacter = characters[left]
            }
            while left < right, !alphanumericsSet.contains(rightCharacter) {
                right -= 1
                rightCharacter = characters[right]
            }
            if leftCharacter != rightCharacter {
                return false
            }
            left += 1
            right -= 1
        }

        return true
    }
}