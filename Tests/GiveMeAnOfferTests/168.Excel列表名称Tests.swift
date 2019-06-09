//
// Created by daubert on 19-6-2.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class ConvertToTitleTests: XCTestCase {

    func testInput() {
        XCTAssertEqual(1.convertToTitle(), "A")
        XCTAssertEqual(28.convertToTitle(), "AB")
        XCTAssertEqual(701.convertToTitle(), "ZY")
    }

    static var allTests = [
        ("Excel列表名称", testInput),
    ]
}