//
// Created by daubert on 2019/8/7.
//
/*
 * @lc app=leetcode.cn id=150 lang=swift
 *
 * [150] 逆波兰表达式求值
 *
 * https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/description/
 *
 * algorithms
 * Medium (45.17%)
 * Likes:    63
 * Dislikes: 0
 * Total Accepted:    12K
 * Total Submissions: 26.6K
 * Testcase Example:  '["2","1","+","3","*"]'
 *
 * 根据逆波兰表示法，求表达式的值。
 *
 * 有效的运算符包括 +, -, *, / 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。
 *
 * 说明：
 *
 *
 * 整数除法只保留整数部分。
 * 给定逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为 0 的情况。
 *
 *
 * 示例 1：
 *
 * 输入: ["2", "1", "+", "3", "*"]
 * 输出: 9
 * 解释: ((2 + 1) * 3) = 9
 *
 *
 * 示例 2：
 *
 * 输入: ["4", "13", "5", "/", "+"]
 * 输出: 6
 * 解释: (4 + (13 / 5)) = 6
 *
 *
 * 示例 3：
 *
 * 输入: ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
 * 输出: 22
 * 解释:
 * ⁠ ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
 * = ((10 * (6 / (12 * -11))) + 17) + 5
 * = ((10 * (6 / -132)) + 17) + 5
 * = ((10 * 0) + 17) + 5
 * = (0 + 17) + 5
 * = 17 + 5
 * = 22
 *
 */
import Foundation

extension CharacterSet {
    public static var mathOperators: CharacterSet {
        return CharacterSet(arrayLiteral: "+", "-", "*", "/")
    }
}

public func evalRPN(_ tokens: String...) -> Int {
    let set = CharacterSet.decimalDigits.union(.mathOperators)
    guard tokens.count > 0,
          tokens.allSatisfy({ $0.rangeOfCharacter(from: set) != nil }) else {
        return 0
    }

    var i = 0
    var sum = [Int]()
    while i < tokens.count {
        let token = tokens[i]
        switch token {
        case "+":
            let tmp1 = sum.removeLast()
            let tmp2 = sum.removeLast()
            sum.append(tmp1 + tmp2)
        case "-":
            let tmp1 = sum.removeLast()
            let tmp2 = sum.removeLast()
            sum.append(tmp2 - tmp1)
        case "*":
            let tmp1 = sum.removeLast()
            let tmp2 = sum.removeLast()
            sum.append(tmp2 * tmp1)
        case "/":
            let tmp1 = sum.removeLast()
            let tmp2 = sum.removeLast()
            sum.append(tmp2 / tmp1)
        default:
            sum.append(Int(token)!)
        }
        i += 1
    }
    return sum.last ?? 0
}