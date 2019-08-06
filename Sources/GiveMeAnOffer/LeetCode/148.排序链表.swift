//
// Created by daubert on 2019/8/4.
//
/*
/*
 * @lc app=leetcode.cn id=148 lang=swift
 *
 * [148] 排序链表
 *
 * https://leetcode-cn.com/problems/sort-list/description/
 *
 * algorithms
 * Medium (61.43%)
 * Likes:    237
 * Dislikes: 0
 * Total Accepted:    18.8K
 * Total Submissions: 30.6K
 * Testcase Example:  '[4,2,1,3]'
 *
 * 在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序。
 *
 * 示例 1:
 *
 * 输入: 4->2->1->3
 * 输出: 1->2->3->4
 *
 *
 * 示例 2:
 *
 * 输入: -1->5->3->4->0
 * 输出: -1->0->3->4->5
 *
 */
*/
import Foundation

extension ListNode where T: Comparable {
    public func sorted() -> ListNode? {
        guard next != nil else {
            return self
        }
        var pre: ListNode?
        var cur1: ListNode? = self
        var cur2 = cur1
        while cur2 != nil, cur2?.next != nil {
            pre = cur1
            cur1 = cur1?.next
            cur2 = cur2?.next?.next
        }
        var node1 = pre?.next?.sorted()
        pre?.next = nil
        let node2 = self.sorted()
        return merge(node1, node2)
    }

    func merge(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var cur1 = l1
        var cur2 = l2

        guard cur1 != nil || cur2 != nil else {
            return  nil
        }

        var dummyHead: ListNode?
        if let val = cur1?.val {
            dummyHead = ListNode(val)
        } else {
            dummyHead = ListNode(l2!.val)
        }
        var cur = dummyHead
        while cur1 != nil || cur2 != nil {
            if cur1 != nil {
                cur?.next = cur2
                cur2 = cur2?.next
            } else if cur2 == nil {
                cur?.next = cur1
                cur1 = cur1?.next
            } else {
                cur?.next = cur1
                cur1 = cur1?.next
            }
            cur = cur?.next
        }
        return dummyHead?.next
    }
}