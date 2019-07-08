//
//  StackProtocol.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/8.
//

import Foundation

public protocol StackProtocol: class {
    
    associatedtype Element
    
    func push(_ x: Element)
    
    @discardableResult func pop() -> Element?
    
    func top() -> Element?
}
