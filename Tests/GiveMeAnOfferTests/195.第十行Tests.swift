//
// Created by daubert on 19-6-13.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class TenthLineTests: XCTestCase {

    func testInput() {
        let content = """
                      Line 1
                      Line 2
                      Line 3
                      Line 4
                      Line 5
                      Line 6
                      Line 7
                      Line 8
                      Line 9
                      Line 10
                      """
        let file = "\(FileManager.default.currentDirectoryPath)/file.txt"
        // 创建临时文件
        XCTAssertTrue(FileManager.default.createFile(atPath: file, contents: content.data(using: .utf8)), "创建临时文件失败")
        defer {
            // 删除临时文件
            try? FileManager.default.removeItem(atPath: file)
        }
        XCTAssertEqual(FileManager.default.tenthLine(filePath: file), "Line 10")
    }

    static var allTests = [
        ("第十行", testInput),
    ]
}
