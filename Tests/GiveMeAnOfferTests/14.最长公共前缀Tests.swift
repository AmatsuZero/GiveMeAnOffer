//
// Created by daubert on 19-5-19.
//

import XCTest
@testable import GiveMeAnOffer

final class LongestCommonPrefixTests: XCTestCase {
    func testInput() {
        XCTAssertEqual(["flower","flow","flight"].longestCommonPrefix(), "fl")
        XCTAssertEqual(["dog","racecar","car"].longestCommonPrefix(), "")
    }
    static var allTests = [
        ("最长公共前缀测试", testInput),
    ]
}
