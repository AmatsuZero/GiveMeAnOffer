//
//  653.两数之和 IV - 输入 BST.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//
/*
 给定一个二叉搜索树和一个目标结果，如果 BST 中存在两个元素且它们的和等于给定的目标结果，则返回 true。
 
 案例 1:
 
 输入:
 5
 / \
 3   6
 / \   \
 2   4   7
 
 Target = 9
 
 输出: True
 
 
 案例 2:
 
 输入:
 5
 / \
 3   6
 / \   \
 2   4   7
 
 Target = 28
 
 输出: False
 */
import Foundation

public extension BinarySearchTree where T == Int {
    
    func findTarget(_ sum: Int) -> Bool {
        
        var set = Set<Int>()
        
        func findTarget(_ root: TreeNode<T>?, _ k: Int) -> Bool {
            
            guard let root = root else {
                return false
            }
            
            if set.contains(root.val) { return true }
            
            set.insert(k - root.val)
            
            return findTarget(root.left, k) || findTarget(root.right, k)
        }
        
        return findTarget(self, sum)
    }
}
