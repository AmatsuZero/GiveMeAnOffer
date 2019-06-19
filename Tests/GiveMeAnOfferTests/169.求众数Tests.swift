//
// Created by daubert on 19-6-19.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class MajorityElementTests: XCTestCase {

    func testInput() {
        XCTAssertEqual([3,2,3].majorityElement(), 3)
        XCTAssertEqual([2,2,1,1,1,2,2].majorityElement(), 2)
    }

    static var allTests = [
        ("求众数", testInput),
    ]
}