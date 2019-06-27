//
//  205.同构字符串.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/26.
//

/*
 给定两个字符串 s 和 t，判断它们是否是同构的。
 
 如果 s 中的字符可以被替换得到 t ，那么这两个字符串是同构的。
 
 所有出现的字符都必须用另一个字符替换，同时保留字符的顺序。两个字符不能映射到同一个字符上，但字符可以映射自己本身。
 
 示例 1:
 
 输入: s = "egg", t = "add"
 输出: true
 示例 2:
 
 输入: s = "foo", t = "bar"
 输出: false
 示例 3:
 
 输入: s = "paper", t = "title"
 输出: true
 说明:
 你可以假设 s 和 t 具有相同的长度。
 */
import Foundation

public extension String {
    func isIsomorphic(with t: String) -> Bool {
        guard self.count == t.count else {
            return false
        }
        
        var map = [Character: Character]()
        var set = Set<Character>()
        
        for (i, c1) in self.enumerated() {
            let index = t.index(t.startIndex, offsetBy: i)
            let c2 = t[index]
            if let c = map[c1] {
                if c != c2 {
                    return false
                }
            } else {
                if set.contains(c2) {
                    return false
                } else {
                    map[c1] = c2
                    set.insert(c2)
                }
            }
        }
        return true
    }
}
