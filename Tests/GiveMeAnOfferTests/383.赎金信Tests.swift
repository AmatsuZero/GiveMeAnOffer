//
// Created by daubert on 19-6-30.
//

import XCTest
@testable import GiveMeAnOffer

final class CanConstructTests: XCTestCase {

    func testInput() {
        XCTAssertFalse(String.canConstruct("a", "b"))
        XCTAssertFalse(String.canConstruct("aa", "ab"))
        XCTAssertTrue(String.canConstruct("aa", "aab"))
    }

    static var allTests = [
        ("赎金信", testInput),
    ]
}
