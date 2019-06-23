//
//  242.有效的字母异位词.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/23.
//
/*
 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
 
 示例 1:
 
 输入: s = "anagram", t = "nagaram"
 输出: true
 示例 2:
 
 输入: s = "rat", t = "car"
 输出: false
 说明:
 你可以假设字符串只包含小写字母。
 
 进阶:
 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
 */
import Foundation

/*
 链接：https://blog.csdn.net/legend_hua/article/details/78226549
 我们从另外一个角度思考，字母一共有多少个？很明显，只有26个（只考虑小写字母）。那么，我们可以为字符串s1和s2分别设置26个计数器，然后判断这对应位置的计数是否相等，如果对应计数完全相等，则为字母易位词。
 */
extension String {
    public func isAnagram(Of t: String) -> Bool {
        guard self.count == t.count else {
            return false
        }
        
        var count1 = [Int](repeating: 0, count: 26)
        var count2 = [Int](repeating: 0, count: 26)
        let firstValue = UInt32("A".utf8CString.first!)
        
        self.uppercased().forEach { char in
            count1[Int(char.unicodeScalars.first!.value - firstValue)] += 1
        }
        
        t.uppercased().forEach { char in
            count2[Int(char.unicodeScalars.first!.value - firstValue)] += 1
        }
        
        var match = true
        
        for i in 0..<26 where count1[i] != count2[i] {
            match = false
            break
        }
        
        return match
    }
    
    public static func isAnagram(_ s: String, _ t: String) -> Bool {
        return s.isAnagram(Of: t)
    }
}
