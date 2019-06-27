//
//  MissingNumberTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/27.
//

import XCTest
@testable import GiveMeAnOffer

final class MissingNumberTests: XCTestCase {

    func testInput() {
        XCTAssertEqual([3,0,1].missingNumber(), 2)
        XCTAssertEqual([9,6,4,2,3,5,7,0,1].missingNumber(), 8)
    }
    
    static var allTests = [
        ("缺失数字", testInput),
    ]

}
