//
//  CompressTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/26.
//

import XCTest
@testable import GiveMeAnOffer

final class CompressTests: XCTestCase {

    func testInput() {
        XCTAssertEqual(["a","a","b","b","c","c","c"].compress(), ["a","2","b","2","c","3"])
        XCTAssertEqual(["a","b","b","b","b","b","b","b","b","b","b","b","b"].compress(), ["a", "b", "1", "2"])
        XCTAssertEqual("aabbccc".compressString(), "a2b2c3")
        XCTAssertEqual("a2b2c3".decompress(), ["a","a","b","b","c","c","c"])
    }
    
    static var allTests = [
        ("压缩字符串", testInput),
    ]

}
