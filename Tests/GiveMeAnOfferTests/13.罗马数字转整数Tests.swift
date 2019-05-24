//
// Created by daubert on 19-5-20.
//

import XCTest
@testable import GiveMeAnOffer

final class RomanToIntTests: XCTestCase {

    func testInput() {
        XCTAssertEqual("III".romanToInt(), 3)
        XCTAssertEqual("IV".romanToInt(), 4)
        XCTAssertEqual("IX".romanToInt(), 9)
        XCTAssertEqual("LVIII".romanToInt(), 58)
        XCTAssertEqual("MCMXCIV".romanToInt(), 1994)
    }

    static var allTests = [
        ("罗马数字转整数", testInput),
    ]
}
