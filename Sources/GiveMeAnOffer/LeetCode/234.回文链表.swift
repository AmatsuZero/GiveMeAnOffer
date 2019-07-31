//
// Created by daubert on 19-7-18.
//

import Foundation

public extension ListNode where T: Equatable {

    static func isPalindrome(_ head: ListNode?) -> Bool {
        return head?.isPalindrome() ?? true
    }

    func isPalindrome() -> Bool {
        guard next != nil else {
            return true
        }

        var slow: ListNode? = self, fast: ListNode? = self
        while fast?.next != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }

        var last = slow?.next, pre: ListNode? = self
        while last?.next != nil {
            let tmp = last?.next
            last?.next = tmp?.next
            tmp?.next = slow?.next
            slow?.next = tmp
        }

        while slow?.next != nil {
            slow = slow?.next
            if let s = slow?.val,
               let p = pre?.val {
                if s != p {
                    return false
                }
            } else if slow != nil {
                return false
            } else {
                return false
            }
            pre = pre?.next
        }

        return true
    }
}