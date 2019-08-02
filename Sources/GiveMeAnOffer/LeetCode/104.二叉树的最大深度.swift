//
//  104.二叉树的最大深度.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/2.
//
/*
 给定一个二叉树，找出其最大深度。
 
 二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。
 
 说明: 叶子节点是指没有子节点的节点。
 
 示例：
 给定二叉树 [3,9,20,null,null,15,7]，
 
 3
 / \
 9  20
 /  \
 15   7
 返回它的最大深度 3 。
 */
import Foundation

public extension TreeNode {
    func maxDepth() -> Int {
        let l1 = left?.maxDepth() ?? 0
        let l2 = right?.maxDepth() ?? 0
        return max(l1, l2) + 1
    }
}
