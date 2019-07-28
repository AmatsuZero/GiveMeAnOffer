//
//  144.二叉树前序遍历.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//

import Foundation
/*
 给定一个二叉树，返回它的 前序 遍历。
 
 示例:
 
 输入: [1,null,2,3]
 1
 \
 2
 /
 3
 
 输出: [1,2,3]
 */
public extension TreeNode {
    
    func preorderTraversal() -> [T] {
        func preHelper(root: TreeNode?, pre: inout [T]) {
            guard let root = root else {
                return
            }
            
            pre.append(root.val)
            preHelper(root: root.left, pre: &pre)
            preHelper(root: root.right, pre: &pre)
        }
        
        var pre = [T]()
        preHelper(root: self, pre: &pre)
        return pre
    }
}
