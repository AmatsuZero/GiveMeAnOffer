//
// Created by daubert on 19-7-23.
//

import Foundation

public extension ListNode {
    func reverse() -> ListNode {
        guard let next = self.next else {// 只有一个结点，直接返回头指针
            return self
        }
        // 反转以第二个结点为头的子链表
        let newHead = next.reverse()
        // next 此时指向子链表的最后一个结点

        // 将之前的头结点放入子链尾
        next.next = self
        self.next = nil

        return newHead
    }
}