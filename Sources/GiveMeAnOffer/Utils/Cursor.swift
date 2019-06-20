//
// Created by daubert on 19-6-20.
//

// https://zhuanlan.zhihu.com/p/69885819

import Foundation

public enum CursorDirection {
    case right(Int)
    case down(Int)
    case left(Int)
    case up(Int)

    public func go() {
        switch self {
        case .up(let step):
            print("\\x1b[\(step)A")
        case .down(let step):
            print("\\x1b[\(step)B")
        case .left(let step):
            print("\\x1b[\(step)D")
        case .right(let step):
            print("\\x1b[\(step)C")
        }
    }
}

public struct CursorEffect: OptionSet {
    public var rawValue: UInt8
    static let bold = CursorEffect(rawValue: 1)
    static let italic = CursorEffect(rawValue: 3)
    static let underline = CursorEffect(rawValue: 4)
    static let all: CursorEffect = [.bold, .italic, .underline]

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

public func print(effect: CursorEffect, _ content: String) {
    let effectDesc = effect.elements()
            .map {
                "\($0)"
            }
            .joined(separator: ";")
    print("\\e[\(effectDesc)m\(content)\\e[0m")
}