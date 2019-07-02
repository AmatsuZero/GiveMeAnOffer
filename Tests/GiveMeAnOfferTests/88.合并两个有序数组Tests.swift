//
// Created by daubert on 19-7-2.
//

import XCTest
@testable import GiveMeAnOffer

final class MergeWithSortedArrayTests: XCTestCase {

    func testInput() {
        XCTAssertEqual([1,2,3,0,0,0].merge(withSortedArray: [2,5,6]), [1,2,2,3,5,6])
    }

    static var allTests = [
        ("合并有序数组", testInput),
    ]
}
