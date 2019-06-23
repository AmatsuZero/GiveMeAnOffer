//
//  35.搜索插入位置.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/5/21.
//
/*
 搜索插入位置
 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
 
 你可以假设数组中无重复元素。
 
 示例 1:
 
 输入: [1,3,5,6], 5
 输出: 2
 示例 2:
 
 输入: [1,3,5,6], 2
 输出: 1
 示例 3:
 
 输入: [1,3,5,6], 7
 输出: 4
 示例 4:
 
 输入: [1,3,5,6], 0
 输出: 0
 */
import Foundation

extension Array where Element: Comparable {
    
    public func searchInsert(_ target: Element) -> Int {
        guard !isEmpty else {
            return 0
        }
        
        var low = 0
        var high = count - 1
        while low <= high {
            let mid = (low + high) / 2
            if self[mid] == target {
                return mid
            } else if self[mid] < target {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return low
    }
    
    public func binarySearch(_ key: Element) -> Int? {
        var lowerBound = 0
        var upperBound = self.count
        while lowerBound < upperBound {
            let midIndex = lowerBound + (upperBound - lowerBound) / 2
            if self[midIndex] == key {
                return midIndex
            } else if self[midIndex] < key {
                lowerBound = midIndex + 1
            } else {
                upperBound = midIndex
            }
        }
        return nil
    }
}
