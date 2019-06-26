//
//  443.压缩字符串.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/25.
//
/*
 给定一组字符，使用原地算法将其压缩。
 
 压缩后的长度必须始终小于或等于原数组长度。
 
 数组的每个元素应该是长度为1 的字符（不是 int 整数类型）。
 
 在完成原地修改输入数组后，返回数组的新长度。
 
 
 
 进阶：
 你能否仅使用O(1) 空间解决问题？
 
 
 
 示例 1：
 
 输入：
 ["a","a","b","b","c","c","c"]
 
 输出：
 返回6，输入数组的前6个字符应该是：["a","2","b","2","c","3"]
 
 说明：
 "aa"被"a2"替代。"bb"被"b2"替代。"ccc"被"c3"替代。
 示例 2：
 
 输入：
 ["a"]
 
 输出：
 返回1，输入数组的前1个字符应该是：["a"]
 
 说明：
 没有任何字符串被替代。
 示例 3：
 
 输入：
 ["a","b","b","b","b","b","b","b","b","b","b","b","b"]
 
 输出：
 返回4，输入数组的前4个字符应该是：["a","b","1","2"]。
 
 说明：
 由于字符"a"不重复，所以不会被压缩。"bbbbbbbbbbbb"被“b12”替代。
 注意每个数字在数组中都有它自己的位置。
 注意：
 
 1. 所有字符都有一个ASCII值在[35, 126]区间内。
 2. 1 <= len(chars) <= 1000。
 */
import Foundation

public extension String {
    
    func compressString() -> String {
        return self.compress().map { String($0) }.joined()
    }
    
    func decompress() -> [Element] {
        guard self.count > 0 else {
            return []
        }
        guard let char = self.first,
            Int(String(char)) == nil else {
                return self.map { $0 }
        }
        
        var newset = [Element]()
        for (i, char) in self.enumerated() {
            if let count = Int(String(char)) {
                let index = self.index(self.startIndex, offsetBy: i - 1)
                newset.append(contentsOf: [Element](repeating: self[index], count: count - 1))
            } else {
                newset.append(char)
            }
        }
        return newset
    }
}

public extension Sequence where Element == Character {
    
    func compress() -> [Element] {
        var newset = [Element]()
        var counter = 1
        self.forEach { element in
            if newset.last == element {
                counter += 1
            } else {
                if counter > 1 {
                    newset.append(contentsOf: "\(counter)")
                }
                newset.append(element)
                counter = 1
            }
        }
        if counter > 1 {
            newset.append(contentsOf: "\(counter)")
        }
        return newset
    }
}
