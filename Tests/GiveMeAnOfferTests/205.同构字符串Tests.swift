//
//  isIsomorphicTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/26.
//

import XCTest
@testable import GiveMeAnOffer

final class IsIsomorphicTests: XCTestCase {

    func testInput() {
        XCTAssertTrue("egg".isIsomorphic(with: "add"))
        XCTAssertFalse("foo".isIsomorphic(with: "bar"))
        XCTAssertTrue("paper".isIsomorphic(with: "title"))
    }
    
    static var allTests = [
        ("同构字符串", testInput),
    ]

}
