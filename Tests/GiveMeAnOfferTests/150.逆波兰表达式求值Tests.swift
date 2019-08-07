//
// Created by daubert on 2019/8/7.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class EvalPRNTests: XCTestCase {

    func testInput() {
        XCTAssertEqual(evalRPN("2", "1", "+", "3", "*"), 9)
        XCTAssertEqual(evalRPN("4", "13", "5", "/", "+"), 6)
        XCTAssertEqual(evalRPN("10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"), 22)
    }

    static var allTests = [
        ("逆波兰表达式求值", testInput),
    ]
}