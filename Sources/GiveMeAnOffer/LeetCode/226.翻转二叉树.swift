//
// Created by daubert on 19-6-9.
//
/*
 * @lc app=leetcode.cn id=226 lang=swift
 *
 * [226] 翻转二叉树
 *
 * https://leetcode-cn.com/problems/invert-binary-tree/description/
 *
 * algorithms
 * Easy (69.46%)
 * Likes:    210
 * Dislikes: 0
 * Total Accepted:    18.1K
 * Total Submissions: 25.9K
 * Testcase Example:  '[4,2,7,1,3,6,9]'
 *
 * 翻转一棵二叉树。
 *
 * 示例：
 *
 * 输入：
 *
 * ⁠    4
 * ⁠  /   \
 * ⁠ 2     7
 * ⁠/ \   / \
 * 1   3 6   9
 *
 * 输出：
 *
 * ⁠    4
 * ⁠  /   \
 * ⁠ 7     2
 * ⁠/ \   / \
 * 9   6 3   1
 *
 * 备注:
 * 这个问题是受到 Max Howell 的 原问题 启发的 ：
 *
 * 谷歌：我们90％的工程师使用您编写的软件(Homebrew)，但是您却无法在面试时在白板上写出翻转二叉树这道题，这太糟糕了。
 *
 */

import Foundation

extension TreeNode {
    public func invert() -> TreeNode? {
        return TreeNode.invertTree(self)
    }

    public static func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root != nil {
            let tempLeft: TreeNode? = root?.left  //  Of course, you can only use 'tempLeft' and erase 'tempRight'. Or vice-versa
            let tempRight: TreeNode? = root?.right

            root?.right = tempLeft
            root?.left = tempRight
        }

        root?.left = invertTree(root?.left)
        root?.right = invertTree(root?.right)

        return root
    }
}