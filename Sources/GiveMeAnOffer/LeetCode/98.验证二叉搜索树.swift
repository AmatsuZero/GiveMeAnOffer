//
//  98.验证二叉搜索树.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/28.
//

/*
 给定一个二叉树，判断其是否是一个有效的二叉搜索树。
 
 假设一个二叉搜索树具有如下特征：
 
 节点的左子树只包含小于当前节点的数。
 节点的右子树只包含大于当前节点的数。
 所有左子树和右子树自身必须也是二叉搜索树。
 示例 1:
 
 输入:
 2
 / \
 1   3
 输出: true
 示例 2:
 
 输入:
 5
 / \
 1   4
 / \
 3   6
 输出: false
 解释: 输入为: [5,1,4,null,null,3,6]。
 根节点的值为 5 ，但是其右子节点值为 4 。
 */
import Foundation

public extension TreeNode where T: Comparable {
    /// 验证是否是二叉搜索树
    func isValidBST() -> Bool {
        let list = inorderTraversal()
        for i in 0..<list.count - 1 where list[i] >= list[i+1] {
            return false
        }
        return true
    }
}

/// https://github.com/raywenderlich/swift-algorithm-club/blob/master/Binary%20Search%20Tree/README.markdown
public class BinarySearchTree<T: Comparable>: TreeNode<T> {
  
    weak private(set) public var parent: BinarySearchTree?
    
    public convenience init(array: [T]) {
        precondition(!array.isEmpty)
        self.init(array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    public func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    public func insert(value: T) {
        if value < self.val {
            if let left = left as? BinarySearchTree {
                left.insert(value: value)
            } else {
                let left = BinarySearchTree(value)
                left.parent = self
                self.left = left
            }
        } else {
            if let right = right as? BinarySearchTree {
                right.insert(value: value)
            } else {
                let right = BinarySearchTree(value)
                right.parent = self
                self.right = right
            }
        }
    }
    
    public func search(value: T) -> BinarySearchTree? {
        if value < self.val {
            if let left = left as? BinarySearchTree {
                return left.search(value: value)
            }
            return nil
        } else if value > self.val {
            if let right = right as? BinarySearchTree {
                return right.search(value: value)
            }
            return nil
        } else {
            return self  // found it!
        }
    }
    
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?
       
        // Replacement for current node can be either biggest one on the left or
        // smallest one on the right, whichever is not nil
        if let right = right as? BinarySearchTree {
            replacement = right.minimum()
        } else if let left = left as? BinarySearchTree {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        // Place the replacement on current node's position
        replacement?.right = right
        replacement?.left = left
        
        if let right = right as? BinarySearchTree {
            right.parent = replacement
        }
        
        if let left = left as? BinarySearchTree {
            left.parent = replacement
        }
        
        reconnectParentTo(node:replacement)
        
        // The current node is no longer part of the tree, so clean it up.
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
}

extension BinarySearchTree {
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            var leftHeight = 0
            if let left = self.left as? BinarySearchTree {
                leftHeight += left.height()
            }
            var rightHeight = 0
            if let right = self.right as? BinarySearchTree {
                rightHeight += right.height()
            }
            return 1 + Swift.max(leftHeight, rightHeight)
        }
    }
    
    
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left as? BinarySearchTree {
            node = next
        }
        return node
    }
    
    public func maximum() -> BinarySearchTree {
        var node = self
        while let next = node.right as? BinarySearchTree {
            node = next
        }
        return node
    }
    
    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
}


extension BinarySearchTree {
    public func predecessor() -> BinarySearchTree<T>? {
        if let left = left as? BinarySearchTree {
            return left.maximum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.val < val { return parent }
                node = parent
            }
            return nil
        }
    }
    
    public func successor() -> BinarySearchTree<T>? {
        if let right = right as? BinarySearchTree {
            return right.minimum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.val > val { return parent }
                node = parent
            }
            return nil
        }
    }
}
