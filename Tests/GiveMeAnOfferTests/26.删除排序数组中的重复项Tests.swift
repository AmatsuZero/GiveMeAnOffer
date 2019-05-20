//
//  26.删除排序数组中的重复项.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/5/20.
//

import XCTest
@testable import GiveMeAnOffer

final class RemoveDuplicatesTests: XCTestCase {
    
    func testInput() {
        var input = [1,2]
        XCTAssertEqual(input.removeDuplicates(), 2)
        
        input = [0,0,1,1,1,2,2,3,3,4]
        XCTAssertEqual(input.removeDuplicates(), 5)
    }
    
    static var allTests = [
        ("删除数组重复项", testInput),
    ]
}
