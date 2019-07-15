//
// Created by daubert on 19-7-15.
//

import XCTest
@testable import GiveMeAnOffer

final class ConstructRectangleTests: XCTestCase {
    func testInput() {
        XCTAssertEqual(CGSize(area: 4), CGSize(width: 2, height: 2))
        XCTAssertEqual(CGSize(area: 2), CGSize(width: 2, height: 1))
    }

    static var allTests = [
        ("构建矩形", testInput),
    ]
}
