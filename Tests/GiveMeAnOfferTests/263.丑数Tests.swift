//
//  263.丑数Tests.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/23.
//

import XCTest
@testable import GiveMeAnOffer

final class IsUglyIntTests: XCTestCase {
    
    func testInput() {
        XCTAssertTrue(6.isUgly)
        XCTAssertTrue(8.isUgly)
        XCTAssertFalse(14.isUgly)
    }
    
    static var allTests = [
        ("丑数", testInput),
    ]
}
