//
// Created by daubert on 2019/7/31.
//
/*
 * @lc app=leetcode.cn id=203 lang=swift
 *
 * [203] 移除链表元素
 *
 * https://leetcode-cn.com/problems/remove-linked-list-elements/description/
 *
 * algorithms
 * Easy (40.97%)
 * Likes:    267
 * Dislikes: 0
 * Total Accepted:    32K
 * Total Submissions: 76.4K
 * Testcase Example:  '[1,2,6,3,4,5,6]\n6'
 *
 * 删除链表中等于给定值 val 的所有节点。
 *
 * 示例:
 *
 * 输入: 1->2->6->3->4->5->6, val = 6
 * 输出: 1->2->3->4->5
 *
 *
 */
import Foundation

extension ListNode where T: Equatable {
    public func remove(_ value: T) -> ListNode? {
        var head: ListNode? = self
        while head != nil, head!.val == value {
            head = head?.next
        }
        var pCurrent = head
        guard pCurrent != nil else {
            return nil
        }
        while pCurrent?.next != nil {
            if pCurrent?.next!.val == value {
                pCurrent?.next = pCurrent?.next?.next
            } else {
                pCurrent = pCurrent?.next
            }
        }
        return head
    }
}