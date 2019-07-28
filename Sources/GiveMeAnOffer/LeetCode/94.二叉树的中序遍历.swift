//
//  94.二叉树的中序遍历.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//

/*
 给定一个二叉树，返回它的中序 遍历。
 
 示例:
 
 输入: [1,null,2,3]
 1
 \
 2
 /
 3
 
 输出: [1,3,2]
 */
import Foundation

public extension TreeNode {
    func inorderTraversal() -> [T] {
        
        func inorderHelper(root: TreeNode?, res: inout [T]) {
            guard let root = root else {
                return
            }
            inorderHelper(root: root.left, res: &res)
            res.append(root.val)
            inorderHelper(root: root.right, res: &res)
        }
        
        var res = [T]()
        inorderHelper(root: self, res: &res)
        return res
    }
}
