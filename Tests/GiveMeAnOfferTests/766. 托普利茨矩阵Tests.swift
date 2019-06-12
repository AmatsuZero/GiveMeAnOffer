//
// Created by daubert on 19-6-13.
//

import XCTest
@testable import GiveMeAnOffer

final class ToeplitzMatrixTests: XCTestCase {

    func testInput() {
        XCTAssertTrue([
            [1,2,3,4],
            [5,1,2,3],
            [9,5,1,2]
        ].isToeplitzMatrix)

        XCTAssertFalse([
            [1,2],
            [2,2]
        ].isToeplitzMatrix)
    }

    static var allTests = [
        ("托普利茨矩阵", testInput),
    ]
}
