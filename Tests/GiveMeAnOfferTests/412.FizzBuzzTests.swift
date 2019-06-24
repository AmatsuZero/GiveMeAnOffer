//
//  FizzBuzzTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/6/24.
//

import XCTest

class FizzBuzzTests: XCTestCase {

    func testInput() {
        XCTAssertEqual(15.fizzBuzz(), [
            "1",
            "2",
            "Fizz",
            "4",
            "Buzz",
            "Fizz",
            "7",
            "8",
            "Fizz",
            "Buzz",
            "11",
            "Fizz",
            "13",
            "14",
            "FizzBuzz"
            ])
        XCTAssertEqual(3.fizzBuzz(), ["1", "2", "Fizz"])
        XCTAssertEqual(1.fizzBuzz(), ["1"])
    }
    
    static var allTests = [
        ("FizzBuzz", testInput),
    ]
}
