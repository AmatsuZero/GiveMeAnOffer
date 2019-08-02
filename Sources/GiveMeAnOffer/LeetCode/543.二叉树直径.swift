//
//  543.二叉树直径.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/2.
//
/*
 给定一棵二叉树，你需要计算它的直径长度。一棵二叉树的直径长度是任意两个结点路径长度中的最大值。这条路径可能穿过根结点。
 
 示例 :
 给定二叉树
 
 1
 / \
 2   3
 / \
 4   5
 返回 3, 它的长度是路径 [4,2,1,3] 或者 [5,2,1,3]。
 
 注意：两结点之间的路径长度是以它们之间边的数目表示。
 */
import Foundation

extension TreeNode {
    public func diameter() -> Int {
        let res = (left?.maxDepth() ?? 0) + (right?.maxDepth() ?? 0)
        return max(res, max(left?.diameter() ?? 0, right?.diameter() ?? 0))
    }
}
