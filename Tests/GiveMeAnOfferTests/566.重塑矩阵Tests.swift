//
//  ReshapeTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/26.
//

import XCTest
@testable import GiveMeAnOffer

final class ReshapeTests: XCTestCase {
    
    func testInput() {
        XCTAssertEqual([
            [1,2],
            [3,4]
            ].reshape(row: 1, column: 4),
                       [[1,2,3,4]])
        XCTAssertEqual([
            [1,2],
            [3,4]].reshape(row: 2, column: 4),
                       [
                        [1,2],
                        [3,4]
            ])
    }
    
    static var allTests = [
        ("压缩字符串", testInput),
    ]
}
