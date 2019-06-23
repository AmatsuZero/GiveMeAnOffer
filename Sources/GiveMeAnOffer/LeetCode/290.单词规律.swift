//
//  290.单词规律.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/23.
//

/*
 给定一种规律 pattern 和一个字符串 str ，判断 str 是否遵循相同的规律。
 
 这里的 遵循 指完全匹配，例如， pattern 里的每个字母和字符串 str 中的每个非空单词之间存在着双向连接的对应规律。
 
 示例1:
 
 输入: pattern = "abba", str = "dog cat cat dog"
 输出: true
 示例 2:
 
 输入:pattern = "abba", str = "dog cat cat fish"
 输出: false
 示例 3:
 
 输入: pattern = "aaaa", str = "dog cat cat dog"
 输出: false
 示例 4:
 
 输入: pattern = "abba", str = "dog dog dog dog"
 输出: false
 说明:
 你可以假设 pattern 只包含小写字母， str 包含了由单个空格分隔的小写字母。
 */
import Foundation

public extension String {
    
    func matchWith(pattern: String) -> Bool {
        let words = components(separatedBy: " ")
        
        //如果个数不一样，肯定不匹配
        guard words.count == pattern.count else {
            return false
        }
        
        var map1 = [Character: String]() //用于存放pattern中对应字符与str中相应字符串的映射对应关系
        //另外还需要设置一个map用来排除abba与dog dog dog dog的情况，也就是字符串与字符之间的映射关系
        var map2 = [String: Character]() //一旦相同的string对应的char不同则说明不匹配
       
        for (i, char) in pattern.enumerated() {
            //单词或者模板未出现，则开始插入键值
            if map1[char] == nil, map2[words[i]] == nil {
                map1[char] = words[i]
                map2[words[i]] = char
            } else if map1[char] != words[i] { //当所有的进行对应配对之后，再对键值进行比较
                return false
            }
        }
        return true
    }
}
