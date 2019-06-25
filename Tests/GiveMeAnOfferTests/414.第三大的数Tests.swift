//
//  ThirdMaxTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/24.
//

import XCTest
@testable import GiveMeAnOffer

class ThirdMaxTests: XCTestCase {

    func testInput() {
        XCTAssertEqual([3, 2, 1].thirdMax(), 1)
        XCTAssertEqual([1, 2].thirdMax(), 2)
        XCTAssertEqual([2, 2, 3, 1].thirdMax(), 1)
        XCTAssertEqual([1,1,2].thirdMax(), 2)
    }
    
    static var allTests = [
        ("第三大的数", testInput),
    ]
}
