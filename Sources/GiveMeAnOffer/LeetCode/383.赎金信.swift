//
// Created by daubert on 19-6-25.
//
/*
/*
 * @lc app=leetcode.cn id=383 lang=swift
 *
 * [383] 赎金信
 *
 * https://leetcode-cn.com/problems/ransom-note/description/
 *
 * algorithms
 * Easy (47.57%)
 * Likes:    41
 * Dislikes: 0
 * Total Accepted:    7.8K
 * Total Submissions: 16.1K
 * Testcase Example:  '"a"\n"b"'
 *
 * 给定一个赎金信 (ransom)
 * 字符串和一个杂志(magazine)字符串，判断第一个字符串ransom能不能由第二个字符串magazines里面的字符构成。如果可以构成，返回
 * true ；否则返回 false。
 *
 * (题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。)
 *
 * 注意：
 *
 * 你可以假设两个字符串均只含有小写字母。
 *
 *
 * canConstruct("a", "b") -> false
 * canConstruct("aa", "ab") -> false
 * canConstruct("aa", "aab") -> true
 *
 *
 */
*/
import Foundation

public extension String {

    static func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        return magazine.canConstruct(part: ransomNote)
    }

    func canConstruct(part note: String) -> Bool {
        var map = [Character: Int]()
        self.forEach { char in
            if let num = map[char] {
                map[char] = num + 1
            } else {
                map[char] = 1
            }
        }

        for char in note {
            if let num = map[char] {
                let n = num - 1
                if n < 0 {
                    return false
                }
                map[char] = n
            } else {
                return false
            }
        }
        return true
    }
}