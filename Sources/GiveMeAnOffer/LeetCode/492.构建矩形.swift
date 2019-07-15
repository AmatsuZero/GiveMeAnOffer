//
// Created by daubert on 19-7-15.
//
/*
 * @lc app=leetcode.cn id=492 lang=swift
 *
 * [492] 构造矩形
 *
 * https://leetcode-cn.com/problems/construct-the-rectangle/description/
 *
 * algorithms
 * Easy (46.11%)
 * Likes:    17
 * Dislikes: 0
 * Total Accepted:    3.8K
 * Total Submissions: 8K
 * Testcase Example:  '1'
 *
 * 作为一位web开发者， 懂得怎样去规划一个页面的尺寸是很重要的。 现给定一个具体的矩形页面面积，你的任务是设计一个长度为 L 和宽度为 W
 * 且满足以下要求的矩形的页面。要求：
 *
 *
 * 1. 你设计的矩形页面必须等于给定的目标面积。
 *
 * 2. 宽度 W 不应大于长度 L，换言之，要求 L >= W 。
 *
 * 3. 长度 L 和宽度 W 之间的差距应当尽可能小。
 *
 *
 * 你需要按顺序输出你设计的页面的长度 L 和宽度 W。
 *
 * 示例：
 *
 *
 * 输入: 4
 * 输出: [2, 2]
 * 解释: 目标面积是 4， 所有可能的构造方案有 [1,4], [2,2], [4,1]。
 * 但是根据要求2，[1,4] 不符合要求; 根据要求3，[2,2] 比 [4,1] 更能符合要求. 所以输出长度 L 为 2， 宽度 W 为 2。
 *
 *
 * 说明:
 *
 *
 * 给定的面积不大于 10,000,000 且为正整数。
 * 你设计的页面的长度和宽度必须都是正整数。
 *
 *
 */
import Foundation
/*
这道题让我们根据面积来求出矩形的长和宽，要求长和宽的差距尽量的小，那么就是说越接近正方形越好。
那么我们肯定是先来判断一下是不是正方行，对面积开方，如果得到的不是整数，说明不是正方形。
那么我们取最近的一个整数，看此时能不能整除，如果不行，就自减1，再看能否整除。
最坏的情况就是面积是质数，最后减到了1，那么返回结果即可，参见代码如下：
*/
public extension CGSize {
    init(area: Int) {
        var r = area.squareRoot()
        while area % r != 0 {
            r -= 1
        }
        self.init(width: area / r, height: r)
    }
}