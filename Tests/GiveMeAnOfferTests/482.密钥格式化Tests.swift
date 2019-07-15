//
// Created by daubert on 19-7-15.
//

import XCTest
@testable import GiveMeAnOffer

final class LicenseKeyFormattingTests: XCTestCase {
    func testInput() {
        XCTAssertEqual("5F3Z-2e-9-w".licenseKeyFormatting(4), "5F3Z-2E9W")
        XCTAssertEqual("2-5g-3-J".licenseKeyFormatting(2), "2-5G-3J")
    }

    static var allTests = [
        ("密钥格式化", testInput),
    ]
}
