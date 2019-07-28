//
// Created by daubert on 19-6-9.
//

import Foundation

public class TreeNode<T> {
    
    public var val: T
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: T) {
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
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(val)"
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
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
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
