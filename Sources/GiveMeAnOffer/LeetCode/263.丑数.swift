//
//  263.丑数.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/23.
//
/*
 编写一个程序判断给定的数是否为丑数。
 
 丑数就是只包含质因数 2, 3, 5 的正整数。
 
 示例 1:
 
 输入: 6
 输出: true
 解释: 6 = 2 × 3
 示例 2:
 
 输入: 8
 输出: true
 解释: 8 = 2 × 2 × 2
 示例 3:
 
 输入: 14
 输出: false
 解释: 14 不是丑数，因为它包含了另外一个质因数 7。
 说明：
 
 1 是丑数。
 输入不会超过 32 位有符号整数的范围: [−231,  231 − 1]。
 */
import Foundation

extension Int {
    
    public var isUgly: Bool {
        
        guard self != 0 else {
            return false
        }
        
        var number = self
        
        while number % 2 == 0 { //判断数能否被2整除
            number = number / 2
        }
        
        while number % 3 == 0 { //判断数能否被3整除
            number = number / 3
        }
        
        while number % 5 == 0 { //判断数能否被5整除
            number = number / 5
        }
      
        return number == 1
    }
}
