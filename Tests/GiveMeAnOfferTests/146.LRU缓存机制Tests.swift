//
// Created by daubert on 2019/8/10.
//

import Foundation

import XCTest
@testable import GiveMeAnOffer

final class LRUCacheTests: XCTestCase {
//cache.put(1, 1);
//* cache.put(2, 2);
//* cache.get(1);       // 返回  1
//* cache.put(3, 3);    // 该操作会使得密钥 2 作废
//* cache.get(2);       // 返回 -1 (未找到)
//* cache.put(4, 4);    // 该操作会使得密钥 1 作废
//* cache.get(1);       // 返回 -1 (未找到)
//* cache.get(3);       // 返回  3
//* cache.get(4);       // 返回  4
    func testInput() {
        let cache = LRUCache<Int, Int>(capacity: 2)
        cache[1] = 1
        cache[2] = 2
        XCTAssertEqual(cache[1], 1)
        cache[3] = 3
        XCTAssertNil(cache[2])
        cache[4] = 4
        XCTAssertNil(cache[1])
        XCTAssertEqual(cache[3], 3)
        XCTAssertEqual(cache[4], 4)
    }

    static var allTests = [
        ("LRU缓存机制", testInput),
    ]
}