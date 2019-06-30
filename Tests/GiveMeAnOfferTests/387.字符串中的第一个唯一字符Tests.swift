//
// Created by daubert on 19-6-30.
//

import XCTest
@testable import GiveMeAnOffer

final class FirstUniqChartTests: XCTestCase {

    func testInput() {
        var text = "leetcode"
        XCTAssertEqual(text.firstUniqChar(), text.startIndex)
        text = "loveleetcode"
        XCTAssertEqual(text.firstUniqChar(), text.index(text.startIndex, offsetBy: 2))
    }

    static var allTests = [
        ("字符串中的第一个唯一字符", testInput),
    ]
}
