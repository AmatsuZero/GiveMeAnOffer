//
//  SumRangeTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/7/9.
//

import XCTest
@testable import GiveMeAnOffer

class SumRangeTests: XCTestCase {

    func testInput() {
        let numArray = NumArray([-2, 0, 3, -5, 2, -1])
        XCTAssertEqual(numArray.sumRange(0..<2), 1)
        XCTAssertEqual(numArray.sumRange(2..<5), -1)
        XCTAssertEqual(numArray.sumRange(0..<5), -3)
    }
    
    static var allTests = [
        ("区域和检索 - 数组不可变", testInput),
    ]

}
