//
// Created by daubert on 19-5-19.
//
/*
 * @lc app=leetcode.cn id=21 lang=swift
 *
 * [21] 合并两个有序链表
 *
 * https://leetcode-cn.com/problems/merge-two-sorted-lists/description/
 *
 * algorithms
 * Easy (54.43%)
 * Likes:    460
 * Dislikes: 0
 * Total Accepted:    69.1K
 * Total Submissions: 126.9K
 * Testcase Example:  '[1,2,4]\n[1,3,4]'
 *
 * 将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。 
 *
 * 示例：
 *
 * 输入：1->2->4, 1->3->4
 * 输出：1->1->2->3->4->4
 *
 *
 */

import Foundation

extension ListNode {

    public static func + (lhs: ListNode<T>, rhs: ListNode<T>) -> ListNode<T>? {
        return merge(left: lhs, right: rhs)
    }

    public static func merge(left l1: ListNode?, right l2: ListNode?) -> ListNode? {
        if(l1 == nil) {return l2}
        if(l2 == nil) {return l1}

        var result:ListNode?

        if(l1!.val <= l2!.val) {
            result = l1
            result!.next = merge(left: l1!.next, right: l2)
        } else {
            result = l2
            result!.next = merge(left:l1, right: l2!.next)
        }
        return result
    }

    public func merge(with another: ListNode?) -> ListNode? {
       return ListNode.merge(left: self, right: another)
    }
}