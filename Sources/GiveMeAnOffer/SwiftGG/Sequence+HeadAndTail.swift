//
// Created by daubert on 19-7-1.
//

import Foundation

// https://swift.gg/2019/06/24/sequence-head-tail/

extension Sequence {

    @available(swift 4.2)
    public var headAndTail: (head: Element, tail: SubSequence)? {
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