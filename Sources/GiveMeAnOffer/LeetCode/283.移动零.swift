//
//  283.移动零.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/23.
//

import Foundation
/*
 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
 
 示例:
 
 输入: [0,1,0,3,12]
 输出: [1,3,12,0,0]
 说明:
 
 必须在原数组上操作，不能拷贝额外的数组。
 尽量减少操作次数。
 */
public extension Array where Element == Int {
    /*
     https://www.jianshu.com/p/05338b2180a1
     这类数组原地删除数据的题目，考察的就是两根指针的应用，注意掌握两根指针的思想，这一类问题就可以迎刃而解了。
     我们设置两根指针slow和fast，fast每次都递增，所以称之为fast，当遍历到不是0的时候，slow指针就存储fast此时遍历的元素，slow加一，当遍历到需要删除的元素0(就相当于移动0到最后)时，略过slow，直接fast++，相当于删除了0.同时设置一个变量记录新数组的长度。
     最后我们再遍历剩下的元素，并给他们赋值为0即可。
     */
    mutating func moveZeros() {
        var fast = 0, slow = 0
        while fast < count {
            if self[fast] != 0 {
                self[slow] = self[fast]
                slow += 1
            }
            fast += 1
        }
        for i in slow..<count {
            self[i] = 0
        }
    }
    
    func moveZeros() -> [Int] {
        var fast = 0, slow = 0
        var new = self
        while fast < count {
            if self[fast] != 0 {
                new[slow] = new[fast]
                slow += 1
            }
            fast += 1
        }
        for i in slow..<count {
            new[i] = 0
        }
        return new
    }
}
