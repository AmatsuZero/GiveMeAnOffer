//
// Created by daubert on 19-6-12.
//

import XCTest
@testable import GiveMeAnOffer

final class MaxSubArrayTests: XCTestCase {

    func testInput() {
        XCTAssertEqual([-2,1,-3,4,-1,2,1,-5,4].maxSubArray(), 6)
        XCTAssertEqual([1].maxSubArray(), 1)
    }

    static var allTests = [
        ("最大子序和", testInput),
    ]
}
