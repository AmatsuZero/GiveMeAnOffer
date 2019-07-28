//
//  173.二叉搜索树迭代器.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//

import Foundation
/*
 实现一个二叉搜索树迭代器。你将使用二叉搜索树的根节点初始化迭代器。
 
 调用 next() 将返回二叉搜索树中的下一个最小的数。
 示例：
 
 BSTIterator iterator = new BSTIterator(root);
 iterator.next();    // 返回 3
 iterator.next();    // 返回 7
 iterator.hasNext(); // 返回 true
 iterator.next();    // 返回 9
 iterator.hasNext(); // 返回 true
 iterator.next();    // 返回 15
 iterator.hasNext(); // 返回 true
 iterator.next();    // 返回 20
 iterator.hasNext(); // 返回 false
 */
public struct BSTIterator<T>: IteratorProtocol where T: Comparable {
    
    public typealias Element = T
    
    private var temp = [T]()
    
    init(_ root: TreeNode<T>) {
        temp.append(contentsOf: root.inorderTraversal())
    }
    
    mutating public func next() -> T? {
        return temp.removeFirst()
    }
    
    func hasNext() -> Bool {
        return !temp.isEmpty
    }
}

extension TreeNode where T: Comparable {
    /// 生成二叉搜索树迭代器
    public __consuming func makeBSTIterator() -> BSTIterator<T>? {
        guard isValidBST() else {
            return nil
        }
        return BSTIterator(self)
    }
}

extension BinarySearchTree: Sequence {
    public typealias Iterator = BSTIterator<T>
    
    public __consuming func makeIterator() -> BSTIterator<T> {
        return BSTIterator(self)
    }
    
    public var underestimatedCount: Int {
        return count
    }
    
    public func contains(_ element: T) -> Bool {
        return search(value: element) != nil
    }
}
