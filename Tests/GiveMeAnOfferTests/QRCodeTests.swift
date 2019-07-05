//
//  QRCodeTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/7/2.
//

import XCTest
@testable import GiveMeAnOffer

final class QRCodeTests: XCTestCase {

    func testInput() {
        do {
            print(try "test".generateQR(isSmall: true))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static var allTests = [
        ("QR Code", testInput),
    ]

}
