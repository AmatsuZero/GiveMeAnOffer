//
//  105.从前序与中序遍历序列构造二叉树.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/31.
//
/*
 根据一棵树的前序遍历与中序遍历构造二叉树。
 
 注意:
 你可以假设树中没有重复的元素。
 
 例如，给出
 
 前序遍历 preorder = [3,9,20,15,7]
 中序遍历 inorder = [9,3,15,20,7]
 返回如下的二叉树：
 
 3
 / \
 9  20
 /  \
 15   7
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import Foundation

extension TreeNode where T: Equatable {
    
    public convenience init?(preorder: [T], inorder: [T]) {
        self.init(preorder: preorder, pStart:0, pEnd: preorder.count,
                  inorder: inorder, iStart: 0, iEnd: inorder.count)
    }
    
    private convenience init?(preorder: [T], pStart: Int, pEnd: Int,
                              inorder: [T], iStart: Int, iEnd: Int) {
        guard pStart != pEnd else {
            return nil
        }
        
        // 拿到节点的值
        let rootVal = preorder[pStart]
        // 创建节点
        self.init(rootVal)
        //在中序遍历中找到根节点的位置
        var i_root_index = 0
        for i in iStart..<iEnd where rootVal == inorder[i] {
            i_root_index = i
            break
        }
        // 确定子树的节点数量
        let leftNum = i_root_index - iStart
        //递归的构造左子树
        self.left = TreeNode<T>(preorder: preorder, pStart: pStart + 1, pEnd: pStart + leftNum + 1,
                                inorder: inorder, iStart: iStart, iEnd: i_root_index)
        //递归的构造右子树
        self.right = TreeNode<T>(preorder: preorder, pStart: pStart + leftNum + 1, pEnd: pEnd,
                                 inorder: inorder, iStart: i_root_index + 1, iEnd: iEnd)
        
    }
    
    public class func buildTree(_ preorder: [T], _ inorder: [T]) -> TreeNode? {
        return buildTreeHelper(preorder: preorder, pStart: 0, pEnd: preorder.count,
                               inorder: inorder, iStart: 0, iEnd: inorder.count)
    }
    
    private class func buildTreeHelper(preorder: [T], pStart: Int, pEnd: Int,
                                       inorder: [T], iStart: Int, iEnd: Int) -> TreeNode? {
        guard pStart != pEnd else {
            return nil
        }
        
        // 拿到节点的值
        let rootVal = preorder[pStart]
        // 创建节点
        let root = TreeNode(rootVal)
        //在中序遍历中找到根节点的位置
        var i_root_index = 0
        for i in iStart..<iEnd where rootVal == inorder[i] {
            i_root_index = i
            break
        }
        // 确定子树的节点数量
        let leftNum = i_root_index - iStart
        //递归的构造左子树
        root.left = buildTreeHelper(preorder: preorder, pStart: pStart + 1, pEnd: pStart + leftNum + 1,
                                    inorder: inorder, iStart: iStart, iEnd: i_root_index)
        //递归的构造右子树
        root.right = buildTreeHelper(preorder: preorder, pStart: pStart + leftNum + 1, pEnd: pEnd,
                                     inorder: inorder, iStart: i_root_index + 1, iEnd: iEnd)
        return root
    }
}
