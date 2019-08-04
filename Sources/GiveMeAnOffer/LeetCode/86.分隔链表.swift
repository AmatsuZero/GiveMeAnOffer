//
// Created by daubert on 2019/8/4.
//

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