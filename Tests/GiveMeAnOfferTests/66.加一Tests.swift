//
//  66.加一Tests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/5/31.
//

import XCTest
@testable import GiveMeAnOffer

final class PlusOneTests: XCTestCase {
    
    func testInput() {
        XCTAssertEqual([0].plusOne(), [1])
        XCTAssertEqual([2].plusOne(), [3])
        XCTAssertEqual([1,2,3].plusOne(), [1,2,4])
        XCTAssertEqual([4,3,2,1].plusOne(), [4,3,2,2])
        XCTAssertEqual([9,9].plusOne(), [1,0,0])
        XCTAssertEqual([1,0,9].plusOne(), [1,1,0])
        XCTAssertEqual([7,2,8,5,0,9,1,2,9,5,3,6,6,7,3,2,8,4,3,7,9,5,7,7,4,7,4,9,4,7,0,1,1,1,7,4,0,0,6].plusOne(), [7,2,8,5,0,9,1,2,9,5,3,6,6,7,3,2,8,4,3,7,9,5,7,7,4,7,4,9,4,7,0,1,1,1,7,4,0,0,7])
    }
    
    static var allTests = [
        ("加一", testInput),
    ]
}
