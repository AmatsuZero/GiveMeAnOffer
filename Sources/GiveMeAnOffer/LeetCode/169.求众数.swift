//
// Created by daubert on 19-6-19.
//

/*
 * @lc app=leetcode.cn id=169 lang=swift
 *
 * [169] 求众数
 *
 * https://leetcode-cn.com/problems/majority-element/description/
 *
 * algorithms
 * Easy (58.97%)
 * Likes:    254
 * Dislikes: 0
 * Total Accepted:    47.6K
 * Total Submissions: 79.9K
 * Testcase Example:  '[3,2,3]'
 *
 * 给定一个大小为 n 的数组，找到其中的众数。众数是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。
 *
 * 你可以假设数组是非空的，并且给定的数组总是存在众数。
 *
 * 示例 1:
 *
 * 输入: [3,2,3]
 * 输出: 3
 *
 * 示例 2:
 *
 * 输入: [2,2,1,1,1,2,2]
 * 输出: 2
 *
 *
 */
import Foundation
/*
用到的算法是：摩尔投票算法
算法在局部变量中定义一个序列元素(value)和一个计数器(count)，

初始化的情况下计数器为0.
算法依次扫描序列中的元素，当处理元素x的时候，如果计数器为0，那么将x赋值给value，然后将计数器count设置为1，如果计数器不为0，那么将序列元素value和x比较，如果相等，那么计数器加1，如果不等，那么计数器减1。
最后存储的序列元素(value)，就是这个序列中最多的元素。

如果不确定是否存储的元素m是最多的元素，还可以进行第二遍扫描判断是否为最多的元素。
*/
extension Collection where Element: Equatable {

    public func majorityElement() -> Element? {

        guard !self.isEmpty else {
            return nil
        }

        var count = 0
        var value: Element?
        self.forEach { e in
            if count == 0 {
                value = e
                count = 1
            } else if value == e {
                count += 1
            } else {
                count -= 1
            }
        }
        return value
    }
}