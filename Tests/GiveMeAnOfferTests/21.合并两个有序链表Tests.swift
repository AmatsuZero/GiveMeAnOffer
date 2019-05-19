//
// Created by daubert on 19-5-19.
//

import XCTest
@testable import GiveMeAnOffer

final class MergeTwoSortedLists: XCTestCase {

    var l1: ListNode<Int>?
    var l2: ListNode<Int>?

    override func setUp() {
        [1,2,4].forEach { val in
            if l1 == nil {
                l1 = ListNode(val)
            } else {
                l1?.append(val)
            }
        }

        [1,3,4].forEach { val in
            if l2 == nil {
                l2 = ListNode(val)
            } else {
                l2?.append(val)
            }
        }
    }

    func testInput() {
        var left: ListNode<Int>?
        [1,1,2,3,4,4].forEach { val in
           if left == nil {
               left = ListNode(val)
           } else {
               left?.append(val)
           }
        }

        XCTAssertEqual(left, l1! + l2!)
    }

    func testCompare() {
       XCTAssertNotEqual(l1, l2)
    }

    override func tearDown() {
        l1 = nil
        l2 = nil
    }

    static var allTests = [
        ("测试比较", testCompare),
        ("合并两个有序连表", testInput),
    ]
}

