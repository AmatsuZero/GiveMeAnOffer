//
// Created by daubert on 19-5-26.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class IsPalindromeStringTests: XCTestCase {

    func testInput() {
        XCTAssertTrue("A man, a plan, a canal: Panama".isPalindrome)
        XCTAssertFalse("race a car".isPalindrome)
        XCTAssertTrue("".isPalindrome)
    }

    static var allTests = [
        ("回文数", testInput),
    ]
}
