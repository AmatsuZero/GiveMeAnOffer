//
//  637.二叉树的层平均值.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/2.
//
/*
 给定一个非空二叉树, 返回一个由每层节点平均值组成的数组.
 
 示例 1:
 
 输入:
 3
 / \
 9  20
 /  \
 15   7
 输出: [3, 14.5, 11]
 解释:
 第0层的平均值是 3,  第1层是 14.5, 第2层是 11. 因此返回 [3, 14.5, 11].
 注意：
 
 节点值的范围在32位有符号整数范围内。
 */
import Foundation

public extension TreeNode where T == Int {
    
    func averageOfLevels() -> [Double] {
        var cur: TreeNode!
        var queue = [self]
        var res = [Double]()
        while !queue.isEmpty {
            var sum = 0.0
            let count = queue.count
            for _ in 0..<count {
                cur = queue.removeFirst()
                sum += Double(cur.val)
                if let leftNode = cur?.left {
                    queue.append(leftNode)
                }
                if let rightNode = cur?.right {
                    queue.append(rightNode)
                }
            }
            res.append(sum / Double(count))
        }
        return res
    }
}
