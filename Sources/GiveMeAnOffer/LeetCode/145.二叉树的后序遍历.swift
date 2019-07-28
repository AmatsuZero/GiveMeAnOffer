//
//  145.二叉树的后序遍历.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//

/*
 给定一个二叉树，返回它的 后序 遍历。
 
 示例:
 
 输入: [1,null,2,3]
 1
 \
 2
 /
 3
 
 输出: [3,2,1]
 */
import Foundation

public extension TreeNode {
    func postorderTraversal() -> [T] {
        
        func postHelper(root: TreeNode?, post: inout [T]) {
            guard let root = root else {
                return
            }
            
            postHelper(root: root.left, post: &post)
            postHelper(root: root.right, post: &post)
            post.append(root.val)
        }
        
        var res = [T]()
        postHelper(root: self, post: &res)
        return res
    }
}
