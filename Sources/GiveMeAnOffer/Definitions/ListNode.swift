//
// Created by daubert on 19-5-19.
//

import Foundation

public class ListNode<T> {
    public var val: T
    public var next: ListNode<T>? = nil

    public init(_ val: T) {
        self.val = val
    }

    public func toArray() -> [T] {
        var array = [T]()
        var node: ListNode<T>? = self
        while node != nil {
            array.append(node!.val)
            node = node?.next
        }
        return array
    }

    public func append(_ val: T) {
        var node :ListNode? = self
        while node != nil {
            if node?.next == nil {
                node?.next = ListNode(val)
                break
            }
            node = node?.next
        }
    }
}

extension ListNode: Equatable where T: Equatable {
    public static func == (lhs: ListNode<T>, rhs: ListNode<T>) -> Bool {
        return lhs.toArray() == rhs.toArray()
    }
}