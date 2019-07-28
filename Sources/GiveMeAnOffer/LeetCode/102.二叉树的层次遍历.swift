//
//  102.二叉树的层次遍历.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//
/*
 给定一个二叉树，返回其按层次遍历的节点值。 （即逐层地，从左到右访问所有节点）。
 
 例如:
 给定二叉树: [3,9,20,null,null,15,7],
 
 3
 / \
 9  20
 /  \
 15   7
 返回其层次遍历结果：
 
 [
 [3],
 [9,20],
 [15,7]
 ]
 */
import Foundation

public extension TreeNode {
    
    func levelOrder(fromBottom: Bool = false) -> [[T]] {
        guard !fromBottom else {
            return levelOrderBottom()
        }
        
        var res = [[T]]()
        var queue = [self]
        
        while !queue.isEmpty {
            var levelData = [T]()
            for _ in 0..<queue.count {
                let tmp = queue.removeFirst()
                
                levelData.append(tmp.val)
                
                if let left = tmp.left {
                    queue.append(left)
                }
                
                if let right = tmp.right {
                    queue.append(right)
                }
            }
            
            res.append(levelData)
        }
        
        return res
    }
}
