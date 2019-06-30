//
// Created by daubert on 19-6-30.
//
/*
 * @lc app=leetcode.cn id=387 lang=swift
 *
 * [387] 字符串中的第一个唯一字符
 *
 * https://leetcode-cn.com/problems/first-unique-character-in-a-string/description/
 *
 * algorithms
 * Easy (38.18%)
 * Likes:    123
 * Dislikes: 0
 * Total Accepted:    32.7K
 * Total Submissions: 83.9K
 * Testcase Example:  '"leetcode"'
 *
 * 给定一个字符串，找到它的第一个不重复的字符，并返回它的索引。如果不存在，则返回 -1。
 *
 * 案例:
 *
 *
 * s = "leetcode"
 * 返回 0.
 *
 * s = "loveleetcode",
 * 返回 2.
 *
 *
 *
 *
 * 注意事项：您可以假定该字符串只包含小写字母。
 *
 */
import Foundation

public extension String {

    func firstUniqChar() -> String.Index? {
        let firstValue = "a".utf8CString.first!

        var freq = [Int](repeating: 0, count: 26)
        for char in self {
            freq[Int(String(char).utf8CString.first! - firstValue)] += 1
        }
        for (i, char) in self.enumerated()
            where freq[Int(String(char).utf8CString.first! - firstValue)] == 1 {
           return self.index(startIndex, offsetBy: i)
        }

        return nil
    }
}