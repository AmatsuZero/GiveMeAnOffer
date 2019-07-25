//
// Created by daubert on 19-7-26.
//
/*
 * @lc app=leetcode.cn id=100 lang=swift
 *
 * [100] 相同的树
 *
 * https://leetcode-cn.com/problems/same-tree/description/
 *
 * algorithms
 * Easy (52.69%)
 * Likes:    192
 * Dislikes: 0
 * Total Accepted:    25.6K
 * Total Submissions: 48.2K
 * Testcase Example:  '[1,2,3]\n[1,2,3]'
 *
 * 给定两个二叉树，编写一个函数来检验它们是否相同。
 *
 * 如果两个树在结构上相同，并且节点具有相同的值，则认为它们是相同的。
 *
 * 示例 1:
 *
 * 输入:       1         1
 * ⁠         / \       / \
 * ⁠        2   3     2   3
 *
 * ⁠       [1,2,3],   [1,2,3]
 *
 * 输出: true
 *
 * 示例 2:
 *
 * 输入:      1          1
 * ⁠         /           \
 * ⁠        2             2
 *
 * ⁠       [1,2],     [1,null,2]
 *
 * 输出: false
 *
 *
 * 示例 3:
 *
 * 输入:       1         1
 * ⁠         / \       / \
 * ⁠        2   1     1   2
 *
 * ⁠       [1,2,1],   [1,1,2]
 *
 * 输出: false
 *
 *
 */

import Foundation

extension TreeNode: Equatable where T: Equatable {

    public func isEqual(_ rhs: TreeNode?) -> Bool {
        return TreeNode.isSameTree(self, rhs)
    }

    public static func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if let p = p, let q = q {
            guard p.val == q.val else {
                return false
            }
            return isSameTree(p.right, q.right) && isSameTree(p.left, q.left)
        } else {
            return p == nil && q == nil
        }
    }

    public static func == (lhs: TreeNode<T>, rhs: TreeNode<T>) -> Bool {
        return isSameTree(lhs, rhs)
    }
}