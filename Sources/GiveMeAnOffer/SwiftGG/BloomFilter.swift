//
// Created by daubert on 19-7-1.
//

// https://swift.gg/2018/12/13/bloom-filters/
import Foundation

public struct BloomFilter<Element: Hashable> {
    private var data: [Bool]
    private let seeds: [Int]

    public var isEmpty: Bool {
        return data.allSatisfy { !$0 }
    }

    public init(size: Int, hashCount: Int) {
        data = Array(repeating: false, count: size)
        seeds = (0..<hashCount).map({ _ in Int.random(in: 0..<Int.max) })
    }

    public init() {
        self.init(size: 512, hashCount: 3)
    }

    private func hashes(for element: Element) -> [Int] {
        return seeds.map({ seed -> Int in
            var hasher = Hasher()
            hasher.combine(element)
            hasher.combine(seed)
            let hashValue = abs(hasher.finalize())
            return hashValue
        })
    }

    public mutating func insert(_ element: Element) {
        hashes(for: element)
                .forEach({ hash in
                    data[hash % data.count] = true
                })
    }

    public func contains(_ element: Element) -> Bool {
        return hashes(for: element)
                .allSatisfy({ hash in
                    data[hash % data.count]
                })
    }
}
