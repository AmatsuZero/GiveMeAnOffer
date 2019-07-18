//
// Created by daubert on 19-7-18.
//
/*
 * @lc app=leetcode.cn id=617 lang=swift
 *
 * [617] 合并二叉树
 *
 * https://leetcode-cn.com/problems/merge-two-binary-trees/description/
 *
 * algorithms
 * Easy (69.96%)
 * Likes:    196
 * Dislikes: 0
 * Total Accepted:    14K
 * Total Submissions: 19.6K
 * Testcase Example:  '[1,3,2,5]\n[2,1,3,null,4,null,7]'
 *
 * 给定两个二叉树，想象当你将它们中的一个覆盖到另一个上时，两个二叉树的一些节点便会重叠。
 *
 * 你需要将他们合并为一个新的二叉树。合并的规则是如果两个节点重叠，那么将他们的值相加作为节点合并后的新值，否则不为 NULL
 * 的节点将直接作为新二叉树的节点。
 *
 * 示例 1:
 *
 *
 * 输入:
 * Tree 1                     Tree 2
 * ⁠         1                         2
 * ⁠        / \                       / \
 * ⁠       3   2                     1   3
 * ⁠      /                           \   \
 * ⁠     5                             4   7
 * 输出:
 * 合并后的树:
 * 3
 * / \
 * 4   5
 * / \   \
 * 5   4   7
 *
 *
 * 注意: 合并必须从两个树的根节点开始。
 *
 */
import Foundation

// https://www.jianshu.com/p/47eb09a7cdf6
extension TreeNode where T == Int {

    public func mergeWith(_ node: TreeNode?) -> TreeNode? {
        return TreeNode.mergeTrees(self, node)
    }

    public static func mergeTrees(_ lhs: TreeNode?, _ rhs: TreeNode?) -> TreeNode? {
        // 空节点直接返回
        guard let t1 = lhs else {
            return rhs
        }
        guard let t2 = rhs else {
            return lhs
        }

        // 根节点权值相加
        t1.val += t2.val

        // 向左右节点第归
        t1.left = mergeTrees(t1.left, t2.left)
        t1.right = mergeTrees(t1.right, t2.right)

        // 返回根结点
        return t1
    }
}