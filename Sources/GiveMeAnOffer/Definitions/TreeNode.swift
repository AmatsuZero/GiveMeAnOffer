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