import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LongestCommonPrefixTests.allTests),
        testCase(ValidParentheses.allTests),
        testCase(MergeTwoSortedLists.allTests),
        testCase(RemoveDuplicatesTests.allTests)
    ]
}
#endif
