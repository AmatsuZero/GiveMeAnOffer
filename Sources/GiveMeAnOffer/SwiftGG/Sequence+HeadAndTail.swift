//
// Created by daubert on 19-7-1.
//

import Foundation

// https://swift.gg/2019/06/24/sequence-head-tail/

public extension Collection {
    var headAndTail: (head: Element, tail: SubSequence)? {
        guard let head = first else { return nil }
        return (head, dropFirst())
    }
}

public extension Sequence {
    var headAndTail: (head: Element, tail: DropWhileSequence<Self>)? {
        var first: Element? = nil
        let tail = drop(while: { element in
            if first == nil {
                first = element
                return true
            } else {
                return false
            }
        })
        guard let head = first else {
            return nil
        }
        return (head, tail)
    }
}
