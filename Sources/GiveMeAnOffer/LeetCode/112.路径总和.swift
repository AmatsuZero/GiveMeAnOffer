//
// Created by daubert on 19-7-16.
//
/*
 * @lc app=leetcode.cn id=112 lang=swift
 *
 * [112] 路径总和
 *
 * https://leetcode-cn.com/problems/path-sum/description/
 *
 * algorithms
 * Easy (46.19%)
 * Likes:    140
 * Dislikes: 0
 * Total Accepted:    18.8K
 * Total Submissions: 40.5K
 * Testcase Example:  '[5,4,8,11,null,13,4,7,2,null,null,null,1]\n22'
 *
 * 给定一个二叉树和一个目标和，判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和。
 *
 * 说明: 叶子节点是指没有子节点的节点。
 *
 * 示例: 
 * 给定如下二叉树，以及目标和 sum = 22，
 *
 * ⁠             5
 * ⁠            / \
 * ⁠           4   8
 * ⁠          /   / \
 * ⁠         11  13  4
 * ⁠        /  \      \
 * ⁠       7    2      1
 *
 *
 * 返回 true, 因为存在目标和为 22 的根节点到叶子节点的路径 5->4->11->2。
 *
 */
import Foundation

extension TreeNode where T == Int {

    public func hasSum(_ sum: Int) -> Bool {
        return check(0, sum)
    }

    private func check(_ sum: Int, _ a: Int) -> Bool {
        if left == nil, let r = right {
            return r.check(sum + val, a)
        }
        if let l = left, right == nil {
            return l.check(sum + val, a)
        }
        return left?.check(sum + val, a) ?? (sum + val == a)
                || right?.check(sum + val, a) ?? (sum + val == a)
    }
}