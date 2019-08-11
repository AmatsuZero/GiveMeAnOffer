//
// Created by daubert on 19-6-2.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class SingleNumberTests: XCTestCase {

    func testInput() {
        XCTAssertEqual([2,2,1].singleNumber(), 1)
        XCTAssertEqual([4,1,2,1,2].singleNumber(), 4)
    }

    static var allTests = [
        ("只出现一次的数字", testInput),
    ]
}