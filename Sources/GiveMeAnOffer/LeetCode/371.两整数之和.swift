//
// Created by daubert on 19-6-19.
//

/*
 * @lc app=leetcode.cn id=371 lang=swift
 *
 * [371] 两整数之和
 *
 * https://leetcode-cn.com/problems/sum-of-two-integers/description/
 *
 * algorithms
 * Easy (51.97%)
 * Likes:    113
 * Dislikes: 0
 * Total Accepted:    11.2K
 * Total Submissions: 21.6K
 * Testcase Example:  '1\n2'
 *
 * 不使用运算符 + 和 - ​​​​​​​，计算两整数 ​​​​​​​a 、b ​​​​​​​之和。
 *
 * 示例 1:
 *
 * 输入: a = 1, b = 2
 * 输出: 3
 *
 *
 * 示例 2:
 *
 * 输入: a = -2, b = 3
 * 输出: 1
 *
 */
import Foundation
/*
这道题原来的解法还是有问题，既然明确了不能用+，-运算符，自然是只能用位运算解决问题，也就是关于二进制的相加。
1 对于二进制的两个数加在一起，若没有进行进位，只要a和b的i为相同，那么总和的i位就是0，也就是抑或操作
2 若只进行进位，只要a和b的i-1位皆为1，总和的i位就为1，这就是位与操作后在进行位移操作
3 递归重复上述步骤，找到没有进位结束。
*/
extension Int {
    public func plus(_ b: Int) -> Int {
        guard b != 0 else {
            return self
        }
        let sum = self ^ b //相加但不进位
        let carry = (self & b) << 1 //进位但不相加
        return sum.plus(carry) //递归
    }

    static func getSum(_ a: Int, _ b: Int) -> Int {
        return a.plus(b)
    }
}