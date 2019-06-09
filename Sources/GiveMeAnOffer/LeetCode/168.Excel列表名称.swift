//
// Created by daubert on 19-6-2.
//
/*
 * @lc app=leetcode.cn id=168 lang=swift
 *
 * [168] Excel表列名称
 *
 * https://leetcode-cn.com/problems/excel-sheet-column-title/description/
 *
 * algorithms
 * Easy (32.23%)
 * Likes:    113
 * Dislikes: 0
 * Total Accepted:    8.5K
 * Total Submissions: 26.1K
 * Testcase Example:  '1'
 *
 * 给定一个正整数，返回它在 Excel 表中相对应的列名称。
 *
 * 例如，
 *
 * ⁠   1 -> A
 * ⁠   2 -> B
 * ⁠   3 -> C
 * ⁠   ...
 * ⁠   26 -> Z
 * ⁠   27 -> AA
 * ⁠   28 -> AB
 * ⁠   ...
 *
 *
 * 示例 1:
 *
 * 输入: 1
 * 输出: "A"
 *
 *
 * 示例 2:
 *
 * 输入: 28
 * 输出: "AB"
 *
 *
 * 示例 3:
 *
 * 输入: 701
 * 输出: "ZY"
 *
 *
 */
import Foundation

extension Int {
    public func convertToTitle() -> String {
        let firstValue = "A".utf8CString.first!
        var res = ""
        var n = self
        while n > 0 {
            n -= 1
            let char = [firstValue + CChar(n % 26)]
            res = String(cString: char) + res
            n /= 26
        }
        return res
    }
}