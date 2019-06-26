//
//  461.汉明距离.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/25.
//

/*
 汉明距离
 Category    Difficulty    Likes    Dislikes
 algorithms    Easy (69.59%)    165    -
 Tags
 Companies
 两个整数之间的汉明距离指的是这两个数字对应二进制位不同的位置的数目。
 
 给出两个整数 x 和 y，计算它们之间的汉明距离。
 
 注意：
 0 ≤ x, y < 231.
 
 示例:
 
 输入: x = 1, y = 4
 
 输出: 2
 
 解释:
 1   (0 0 0 1)
 4   (0 1 0 0)
 ↑   ↑
 
 上面的箭头指出了对应二进制位不同的位置。
 */
import Foundation
/*
 　思路：
 
 　　　　01.将两个给定的数进行 异或(^)运算后保存在变量a，汉明距离就是a的二进制中1的个数
 
 　　　　02.当a不为0时，和0x01进行按位与(&)运算。如果结果为1，则统计变量加1
 
 　　　　03.将a右移一位，重复第02步
 */
public extension Int {
    func hammingDistance(between y: Int) -> Int {
        var cnt = 0
        var x = self ^ y
        while x != 0 {
            if x & 0x01 != 0 {
                cnt += 1
            }
            x = x >> 1
        }
        return cnt
    }
}
