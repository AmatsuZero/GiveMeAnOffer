//
//  155.最小栈.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/8.
//
/*
 设计一个支持 push，pop，top 操作，并能在常数时间内检索到最小元素的栈。
 
 push(x) -- 将元素 x 推入栈中。
 pop() -- 删除栈顶的元素。
 top() -- 获取栈顶元素。
 getMin() -- 检索栈中的最小元素。
 示例:
 
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.getMin();   --> 返回 -2.
 */
import Foundation

public protocol MinStackProtocol: StackProtocol {
    func getMin() -> Element?
}

// https://zhuanlan.zhihu.com/p/49854919
public class MinStack: MinStackProtocol {
   
    public typealias Element = Int
    
    private var stack = [Element]()
    
    private(set) var min: Element?
    
    public func getMin() -> Int? {
        return min
    }
    
    public func push(_ x: Int) {
        if stack.isEmpty {
            stack.append(x)
            min = x
        } else {
            stack.append(x - min!)
            if x < min! {
                min = x
            }
        }
    }
    
    @discardableResult
    public func pop() -> Int? {
        guard !stack.isEmpty else {
            return nil
        }
        let data = self.stack.popLast()!
        if data > 0 {
            if stack.isEmpty {// 因为第一次入栈时的值做为最小值，此处不需要加上min
                return data
            } else {
                return data + min!
            }
        } else {
            let old = self.min!
            self.min = self.min! - data
            return old
        }
    }
    
    public func top() -> Int? {
        guard !stack.isEmpty else {
            return nil
        }
        if stack.last! > 0 {
            return stack.last! + min!
        } else {
            return min
        }
    }
}
