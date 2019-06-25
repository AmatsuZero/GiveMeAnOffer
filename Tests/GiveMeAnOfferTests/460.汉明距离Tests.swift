//
//  HammingDistanceTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/25.
//

import XCTest
@testable import GiveMeAnOffer

class HammingDistanceTests: XCTestCase {

    func testInput() {
        XCTAssertEqual(1.hammingDistance(between: 4), 2)
    }
    
    static var allTests = [
        ("汉明距离", testInput),
    ]

}
