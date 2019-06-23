//
//  35.搜索插入位置Tests.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/5/22.
//

import XCTest
@testable import GiveMeAnOffer

final class SearchInsertTests: XCTestCase {
    
    func testInput() {
        XCTAssertEqual([1,3,5,6].searchInsert(5), 2)
        XCTAssertEqual([1,3,5,6].searchInsert(2), 1)
        XCTAssertEqual([1,3,5,6].searchInsert(7), 4)
        XCTAssertEqual([1,3,5,6].searchInsert(0), 0)
    }
    
    static var allTests = [
        ("搜索插入位置", testInput),
    ]
}
