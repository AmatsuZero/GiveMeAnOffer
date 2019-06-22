//
// Created by daubert on 19-6-22.
//

import XCTest
@testable import GiveMeAnOffer

final class ArrayRotateTests: XCTestCase {

    func testInput() {
        XCTAssertEqual([1,2,3,4,5,6,7].rotate(step: 0), [1,2,3,4,5,6,7])
        XCTAssertEqual([1,2,3,4,5,6,7].rotate(step: 1), [7,1,2,3,4,5,6])
        XCTAssertEqual([1,2,3,4,5,6,7].rotate(step: 2), [6,7,1,2,3,4,5])
        XCTAssertEqual([1,2,3,4,5,6,7].rotate(step: 3), [5,6,7,1,2,3,4])
        XCTAssertEqual([1,2,3,4,5,6,7].rotate(step: 4), [4,5,6,7,1,2,3])
        XCTAssertEqual([1,2,3,4,5,6,7].rotate(step: 5), [3,4,5,6,7,1,2])
        XCTAssertEqual([1,2,3,4,5,6,7].rotate(step: 6), [2,3,4,5,6,7,1])

        XCTAssertEqual([1,2].rotate(step: 1), [2,1])
        XCTAssertEqual([1,2].rotate(step: 3), [2,1])
    }

    static var allTests = [
        ("旋转数组", testInput),
    ]
}
