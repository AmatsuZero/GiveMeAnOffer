//
// Created by daubert on 19-6-19.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class GetSumTests: XCTestCase {

    func testInput() {
        XCTAssertEqual(Int.getSum(1, 2), 3)
        XCTAssertEqual(Int.getSum(-2, 3), 1)
    }

    static var allTests = [
        ("两整数之和", testInput),
    ]
}