//
// Created by daubert on 2019/7/31.
//
/*
 * @lc app=leetcode.cn id=106 lang=swift
 *
 * [106] 从中序与后序遍历序列构造二叉树
 *
 * https://leetcode-cn.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/description/
 *
 * algorithms
 * Medium (60.68%)
 * Likes:    98
 * Dislikes: 0
 * Total Accepted:    10.9K
 * Total Submissions: 17.3K
 * Testcase Example:  '[9,3,15,20,7]\n[9,15,7,20,3]'
 *
 * 根据一棵树的中序遍历与后序遍历构造二叉树。
 * 
 * 注意:
 * 你可以假设树中没有重复的元素。
 * 
 * 例如，给出
 * 
 * 中序遍历 inorder = [9,3,15,20,7]
 * 后序遍历 postorder = [9,15,7,20,3]
 * 
 * 返回如下的二叉树：
 * 
 * ⁠   3
 * ⁠  / \
 * ⁠ 9  20
 * ⁠   /  \
 * ⁠  15   7
 * 
 * 
 */
import Foundation

extension TreeNode where T: Equatable {
    class func buildTree(inorder: [T], postorder: [T]) -> TreeNode? {
        return build(inorder: inorder, instart: 0, inend: inorder.count-1,
                postorder: postorder, pStart: postorder.count-1)
    }

    private class func build(inorder: [T], instart: Int, inend: Int,
                     postorder: [T], pStart: Int) -> TreeNode? {
        guard pStart >= 0, instart <= inend else {
            return nil
        }
        let root = TreeNode(postorder[pStart])
        var inindex = 0
        for i in instart...inend where inorder[i] == root.val {
            inindex = i
            break
        }
        root.right = build(inorder: inorder, instart: inindex+1, inend: inend,
                postorder: postorder, pStart: pStart-1)
        root.left = build(inorder: inorder, instart: instart, inend: inindex-1,
                postorder: postorder, pStart: pStart-(inend-inindex)-1)
        return root
    }
}