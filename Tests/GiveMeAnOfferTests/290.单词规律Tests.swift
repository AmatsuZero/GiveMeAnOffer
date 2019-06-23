//
//  290.单词规律Tests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/23.
//

import XCTest
@testable import GiveMeAnOffer

final class WordPatternTests: XCTestCase {
    
    func testInput() {
        XCTAssertTrue("dog cat cat dog".matchWith(pattern: "abba"))
        XCTAssertFalse("dog cat cat fish".matchWith(pattern: "abba"))
        XCTAssertFalse("dog cat cat dog".matchWith(pattern: "aaaa"))
        XCTAssertFalse("dog dog dog dog".matchWith(pattern: "abba"))
    }
    
    static var allTests = [
        ("单词规律", testInput),
    ]
}
