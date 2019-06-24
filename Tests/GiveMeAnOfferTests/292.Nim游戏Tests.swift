//
//  292.Nim游戏Tests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/24.
//

import XCTest
@testable import GiveMeAnOffer

final class CanWinNimTests: XCTestCase {
    
    func testInput() {
        XCTAssertFalse(4.canWinNim)
        XCTAssertTrue(5.canWinNim)
    }
    
    static var allTests = [
        ("Nim游戏", testInput),
    ]
}
