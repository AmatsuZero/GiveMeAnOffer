//
//  RotateTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/7/7.
//

import XCTest
@testable import GiveMeAnOffer

class RotateTests: XCTestCase {
    
    func testInput() {
        var input = [
            [1,2,3],
            [4,5,6],
            [7,8,9]
        ]
        input.rotate()
        XCTAssertEqual(input,
                       [
                        [7,4,1],
                        [8,5,2],
                        [9,6,3]
            ])
        
        input = [
            [ 5, 1, 9,11],
            [ 2, 4, 8,10],
            [13, 3, 6, 7],
            [15,14,12,16]
        ]
        input.rotate()
        XCTAssertEqual(input,
                       [
                        [15,13, 2, 5],
                        [14, 3, 4, 1],
                        [12, 6, 8, 9],
                        [16, 7,10,11]
            ])
    }
    
    static var allTests = [
        ("旋转图像", testInput),
    ]
}
