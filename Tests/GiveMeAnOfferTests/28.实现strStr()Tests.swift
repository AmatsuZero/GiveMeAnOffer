//
// Created by daubert on 19-5-20.
//

import XCTest
@testable import GiveMeAnOffer

final class StrStrTests: XCTestCase {

    func testInput() {
        XCTAssertEqual("hello".strStr("ll"), 2)
        XCTAssertEqual("aaaaa".strStr("bba"), -1)
        XCTAssertEqual("u".strStr(""), 0)
        XCTAssertEqual("o".strStr("op"), -1)
    }

    static var allTests = [
        ("实现strStr()", testInput),
    ]
}
