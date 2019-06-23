import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LongestCommonPrefixTests.allTests),
        testCase(ValidParentheses.allTests),
        testCase(MergeTwoSortedLists.allTests),
        testCase(RemoveDuplicatesTests.allTests),
        testCase(StrStrTests.allTests),
        testCase(IsPalindromeIntTests.allTests),
        testCase(IsPalindromeStringTests.allTests),
        testCase(PlusOneTests.allTests),
        testCase(SingleNumberTests.allTests),
        testCase(ConvertToTitleTests.allTests),
        testCase(MaxSubArrayTests.allTests),
        testCase(ToeplitzMatrixTests.allTests),
        testCase(TenthLineTests.allTests),
        testCase(MySqrtTests.allTests),
        testCase(MajorityElementTests.allTests),
        testCase(GetSumTests.allTests),
        testCase(ArrayRotateTests.allTests),
        testCase(IsAnagramStringTests.allTests)
    ]
}
#endif
