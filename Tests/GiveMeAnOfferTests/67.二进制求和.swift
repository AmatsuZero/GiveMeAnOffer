//
//  67.二进制求和.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/5/31.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class AddBinaryTests: XCTestCase {
    
    func testInput() {
        XCTAssertEqual("11".addBinary("1"), "100")
        XCTAssertEqual("1010".addBinary("1011"), "10101")
    }
    
    static var allTests = [
        ("回文数", testInput),
    ]
}
