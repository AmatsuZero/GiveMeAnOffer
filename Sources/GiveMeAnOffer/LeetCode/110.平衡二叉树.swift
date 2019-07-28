//
// Created by daubert on 19-7-25.
//
/*
 * @lc app=leetcode.cn id=110 lang=swift
 *
 * [110] 平衡二叉树
 *
 * https://leetcode-cn.com/problems/balanced-binary-tree/description/
 *
 * algorithms
 * Easy (47.67%)
 * Likes:    133
 * Dislikes: 0
 * Total Accepted:    22.8K
 * Total Submissions: 46.6K
 * Testcase Example:  '[3,9,20,null,null,15,7]'
 *
 * 给定一个二叉树，判断它是否是高度平衡的二叉树。
 *
 * 本题中，一棵高度平衡二叉树定义为：
 *
 *
 * 一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过1。
 *
 *
 * 示例 1:
 *
 * 给定二叉树 [3,9,20,null,null,15,7]
 *
 * ⁠   3
 * ⁠  / \
 * ⁠ 9  20
 * ⁠   /  \
 * ⁠  15   7
 *
 * 返回 true 。
 *
 * 示例 2:
 *
 * 给定二叉树 [1,2,2,3,3,null,null,4,4]
 *
 * ⁠      1
 * ⁠     / \
 * ⁠    2   2
 * ⁠   / \
 * ⁠  3   3
 * ⁠ / \
 * ⁠4   4
 *
 *
 * 返回 false 。
 *
 */
import Foundation

// 两层递归，第一层递归求二叉树的左右子树是否为高度平衡树，第二层求二叉树的高度。
public extension TreeNode {

    var height: Int {
        let left = self.left?.height ?? 0
        let right = self.right?.height ?? 0
        return Swift.max(left + 1, right + 1)
    }

    func isBalanced() -> Bool {
        guard abs((left?.height ?? 0) - (right?.height ?? 0)) <= 1 else {
            return  false
        }
        return (left?.isBalanced() ?? true) && (right?.isBalanced() ?? true)
    }
}
