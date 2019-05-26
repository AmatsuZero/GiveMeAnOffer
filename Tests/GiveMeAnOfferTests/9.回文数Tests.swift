//
// Created by daubert on 19-5-26.
//

import XCTest
@testable import GiveMeAnOffer

final class IsPalindromeIntTests: XCTestCase {

    func testInput() {
        XCTAssertTrue(121.isPalindrome)
        XCTAssertFalse(10.isPalindrome)
        XCTAssertFalse((-121).isPalindrome)
    }

    static var allTests = [
        ("回文数", testInput),
    ]
}
