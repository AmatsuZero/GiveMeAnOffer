//
// Created by daubert on 19-6-14.
//

import XCTest
@testable import GiveMeAnOffer

final class MySqrtTests: XCTestCase {

    func testInput() {
        XCTAssertEqual(4.squareRoot(), 2)
        XCTAssertEqual(8.squareRoot(), 2)
    }

    static var allTests = [
        ("X的平方根", testInput),
    ]
}
