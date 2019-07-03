//
//  88.合并两个有序数组Tests.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/2.
//
/*
 给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。
 
 说明:
 
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
 示例:
 
 输入:
 nums1 = [1,2,3,0,0,0], m = 3
 nums2 = [2,5,6],       n = 3
 
 输出: [1,2,2,3,5,6]
 */
import Foundation

/*
 由于合并后A数组的大小必定是m+n，所以从最后面开始往前赋值，先比较A和B中最后一个元素的大小，把较大的那个插入到m+n-1的位置上，再依次向前推。
 如果A中所有的元素都比B小，那么前m个还是A原来的内容，没有改变。如果A中的数组比B大的，当A循环完了，B中还有元素没加入A，直接用个循环把B中所有的元素覆盖到A剩下的位置。

 */
public extension Array where Element: Comparable {

    func merge(withSortedArray array: [Element]) -> [Element] {
        var newArray = self
        var k = self.count - 1,
        j = array.count - 1,
        i = k - j - 1

        while i >= 0, j >= 0 {
            if newArray[i] > array[j] {
                newArray[k] = newArray[i]
                k -= 1
                i -= 1
            } else {
                newArray[k] = array[j]
                k -= 1
                j -= 1
            }
        }

        while i >= 0 {
            newArray[k] = newArray[i]
            k -= 1
            i -= 1
        }
        
        while j >= 0 {
            newArray[k] = array[j]
            k -= 1
            j -= 1
        }
       
        return newArray
    }
}
