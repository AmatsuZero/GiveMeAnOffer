//
// Created by daubert on 19-6-9.
//

import Foundation

public class TreeNode<T> {
    
    public var val: T!
    public var left: TreeNode?
    public var right: TreeNode?
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public init(_ val: T!) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

extension TreeNode {
    public enum TraversalOrder {
        case preorder
        case postorder
        case inorder
        
        public func traversal(root: TreeNode?) -> [T] {
            switch self {
            case .preorder:
                return root?.preorderTraversal() ?? []
            case .postorder:
                return root?.postorderTraversal() ?? []
            case .inorder:
                return root?.inorderTraversal() ?? []
            }
        }
    }
    
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(val)
        right?.traverseInOrder(process: process)
    }
    
    public func traversePreOrder(process: (T) -> Void) {
        process(val)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(val)
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += val != nil ? "\(val!)" : "Empty"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}

extension TreeNode {
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left {
            a += left.map(formula: formula)
        }
        a.append(formula(val))
        if let right = right {
            a += right.map(formula: formula)
        }
        return a
    }
    
    public func toArray() -> [T] {
        return map { $0 }
    }
}

extension TreeNode {
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
}
