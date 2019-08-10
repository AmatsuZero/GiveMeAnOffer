//
// Created by daubert on 2019/8/10.
//
/*
 * @lc app=leetcode.cn id=147 lang=swift
 *
 * [147] 对链表进行插入排序
 *
 * https://leetcode-cn.com/problems/insertion-sort-list/description/
 *
 * algorithms
 * Medium (59.46%)
 * Likes:    77
 * Dislikes: 0
 * Total Accepted:    9.4K
 * Total Submissions: 15.7K
 * Testcase Example:  '[4,2,1,3]'
 *
 * 对链表进行插入排序。
 *
 *
 * 插入排序的动画演示如上。从第一个元素开始，该链表可以被认为已经部分排序（用黑色表示）。
 * 每次迭代时，从输入数据中移除一个元素（用红色表示），并原地将其插入到已排好序的链表中。
 *
 *
 *
 * 插入排序算法：
 *
 *
 * 插入排序是迭代的，每次只移动一个元素，直到所有元素可以形成一个有序的输出列表。
 * 每次迭代中，插入排序只从输入数据中移除一个待排序的元素，找到它在序列中适当的位置，并将其插入。
 * 重复直到所有输入数据插入完为止。
 *
 *
 *
 *
 * 示例 1：
 *
 * 输入: 4->2->1->3
 * 输出: 1->2->3->4
 *
 *
 * 示例 2：
 *
 * 输入: -1->5->3->4->0
 * 输出: -1->0->3->4->5
 *
 *
 */
import Foundation

extension ListNode where T: Comparable {
    public func insertionSort() -> ListNode {
        var head = self,
                now = self.next,
                pre: ListNode? = self
        while now !== nil {
            var loc:ListNode? = head, insert: ListNode?
            while loc != nil,
                  loc != now,
                  loc!.val <= now!.val {
                insert = loc
                loc = loc?.next
            }
            if loc !== now {
                pre?.next = now?.next
                if insert == nil {
                    now?.next = head
                    head = now!
                } else {
                    now?.next = insert?.next
                    insert?.next = now
                }
            } else {
                pre = pre?.next
            }
            now = pre?.next
        }
        return head
    }
}