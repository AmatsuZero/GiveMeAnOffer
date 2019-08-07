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
        testCase(IsAnagramStringTests.allTests),
        testCase(IsUglyIntTests.allTests),
        testCase(MoveZeroTests.allTests),
        testCase(WordPatternTests.allTests),
        testCase(CanWinNimTests.allTests),
        testCase(FizzBuzzTests.allTests),
        testCase(ThirdMaxTests.allTests),
        testCase(CompressTests.allTests),
        testCase(ReshapeTests.allTests),
        testCase(IsIsomorphicTests.allTests),
        testCase(MissingNumberTests.allTests),
        testCase(CanConstructTests.allTests),
        testCase(FirstUniqChartTests.allTests),
        testCase(ChatRoomTests.allTests),
        testCase(MergeWithSortedArrayTests.allTests),
        testCase(QRCodeTests.allTests),
        testCase(RotateTests.allTests),
        testCase(MinStackTests.allTests),
        testCase(SumRangeTests.allTests),
        testCase(ConstructRectangleTests.allTests),
        testCase(LicenseKeyFormattingTests.allTests),
        testCase(BinarySearchTreeTests.allTests),
        testCase(TrieTests.allTests),
        testCase(EvalPRNTests.allTests)
    ]
}
#endif
