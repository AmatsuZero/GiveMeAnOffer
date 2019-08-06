//
// Created by daubert on 2019/8/4.
//
/*
 * @lc app=leetcode.cn id=86 lang=swift
 *
 * [86] 分隔链表
 *
 * https://leetcode-cn.com/problems/partition-list/description/
 *
 * algorithms
 * Medium (51.46%)
 * Likes:    105
 * Dislikes: 0
 * Total Accepted:    11.7K
 * Total Submissions: 22.8K
 * Testcase Example:  '[1,4,3,2,5,2]\n3'
 *
 * 给定一个链表和一个特定值 x，对链表进行分隔，使得所有小于 x 的节点都在大于或等于 x 的节点之前。
 *
 * 你应当保留两个分区中每个节点的初始相对位置。
 *
 * 示例:
 *
 * 输入: head = 1->4->3->2->5->2, x = 3
 * 输出: 1->2->2->4->3->5
 *
 *
 */
import Foundation

extension ListNode where T: Comparable {
    public func partition(by n: T) -> ListNode? {
        guard next != nil else {
            return self
        }
        let newHead1: ListNode? = ListNode(n)
        var temp1 = newHead1

        let newHead2: ListNode? = ListNode(n)
        var temp2 = newHead2

        var head: ListNode? = self
        while head != nil {
            if head!.val < n {// 小于年的节点放入新链表1
                temp1?.next = head
                temp1 = head
            } else {// 大于等于n的节点放入新链表2
                temp2?.next = head
                temp2 = head
            }
            head = head?.next
        }
        temp1?.next = newHead2?.next
        temp2?.next = nil

        return newHead1?.next
    }
}