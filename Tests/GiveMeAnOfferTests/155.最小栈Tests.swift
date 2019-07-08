//
//  MinStackTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/7/8.
//

import XCTest
@testable import GiveMeAnOffer

class MinStackTests: XCTestCase {

    func testInput() {
        let minStack = MinStack()
        minStack.push(-2)
        minStack.push(0)
        minStack.push(-3)
        XCTAssertEqual(minStack.getMin(), -3)
        minStack.pop()
        XCTAssertEqual(minStack.top(), 0)
        XCTAssertEqual(minStack.getMin(), -2)
    }
    
    static var allTests = [
        ("最小栈", testInput),
    ]
}
