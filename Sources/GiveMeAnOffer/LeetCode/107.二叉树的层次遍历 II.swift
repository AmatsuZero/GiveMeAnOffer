//
//  107.二叉树的层次遍历 II.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//

import Foundation
/*
 给定一个二叉树，返回其节点值自底向上的层次遍历。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）
 
 例如：
 给定二叉树 [3,9,20,null,null,15,7],
 
 3
 / \
 9  20
 /  \
 15   7
 返回其自底向上的层次遍历为：
 
 [
 [15,7],
 [9,20],
 [3]
 ]
 */
public extension TreeNode {
    
    func levelOrderBottom() -> [[T]] {
        var res = [[T]]()
        var queue = [self]
        while !queue.isEmpty {
            var subList = [T]()
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                subList.append(node.val)
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.insert(subList, at: 0)
        }
        return res
    }
}
