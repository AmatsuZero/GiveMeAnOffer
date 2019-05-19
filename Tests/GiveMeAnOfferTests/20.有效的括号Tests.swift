//
// Created by daubert on 19-5-19.
//

import XCTest
@testable import GiveMeAnOffer

final class ValidParentheses: XCTestCase {
    func testInput() {
        XCTAssertTrue("()".isValidParenthesisPair())
        XCTAssertTrue("()[]{}".isValidParenthesisPair())
        XCTAssertFalse("(]".isValidParenthesisPair())
        XCTAssertFalse("([)]".isValidParenthesisPair())
        XCTAssertTrue("{[]}".isValidParenthesisPair())
        XCTAssertFalse("[".isValidParenthesisPair())
    }
    static var allTests = [
        ("有效的括号", testInput),
    ]
}
