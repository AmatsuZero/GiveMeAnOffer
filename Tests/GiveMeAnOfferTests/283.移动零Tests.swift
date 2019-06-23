//
//  283.移动零Tests.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/23.
//

import XCTest
@testable import GiveMeAnOffer

final class MoveZeroTests: XCTestCase {
    
    func testInput() {
       XCTAssertEqual([0, 1, 0, 3, 12].moveZeros(), [1, 3, 12, 0, 0])
    }
    
    static var allTests = [
        ("移动零", testInput),
    ]
}
