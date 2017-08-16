//
//  ExpandableNode.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public protocol Node: class {
    var count: Int { get }
    var identifier: String! { get }
    weak var parent: Node? { get set }
}

public protocol StaticNode: Node { }

public protocol DynamicNode: Node {
    var active: Bool { get set }
    var children: [Node] { get set }
    
    subscript(index: Int) -> Node? { get }
}

public extension StaticNode {
    var count: Int {
        return 1
    }
}

public extension DynamicNode {
    var count: Int {
        var total = self is NodeContainer ? 0 : 1
        if active {
            children.forEach({ total += $0.count })
        }
        return total
    }
    
    var ifActiveCount: Int {
        var total = 1
        children.forEach({ total += $0.count })
        return total
    }
    
    subscript(index: Int) -> Node? {
        var total = 0
        for cell in children {
            if index == total && !(cell is NodeContainer) {
                return cell
            }
            if let cellArray = cell as? NodeContainer {
                if cellArray.active {
                    if let indexCell = cellArray[index - total] {
                        return indexCell
                    }
                }
            }
            else if let dynamicCell = cell as? DynamicNode {
                if dynamicCell.active {
                    if let indexCell = dynamicCell[index - total - 1] {
                        return indexCell
                    }
                }
            }
            total += cell.count
        }
        return nil
    }
    
    func indexOf(_ node: Node) -> Int? {
        if self === node { return 0 }
        var total = 1
        for cell in children {
            if cell === node {
                return total
            }
            if let dynamicNode = cell as? DynamicNode {
                if dynamicNode.active {
                    if let index = dynamicNode.indexOf(node) {
                        return total + index
                    }
                }
            }
            total += cell.count
        }
        return nil
    }
    
    func append(_ node: Node) {
        children.append(node)
        node.parent = self
    }
}

open class NodeContainer: DynamicNode, Sequence {
    public var active = true
    public var children: [Node] = []
    public var identifier: String!
    public weak var parent: Node?
    
    public init() {}
    
    public var count: Int {
        if !active { return 0 }
        var total = 0
        children.forEach({ total += $0.count })
        return total
    }
    
    var ifActiveCount: Int {
        var total = 0
        children.forEach({ total += $0.count })
        return total
    }
    
    public func index(of node: Node) -> Int? {
        var total = 0
        for cell in children {
            if cell === node {
                return total
            }
            if let dynamicNode = cell as? DynamicNode {
                if dynamicNode.active {
                    if let index = dynamicNode.indexOf(node) {
                        return total + index
                    }
                }
            }
            total += cell.count
        }
        return nil
    }
    
    func append(_ node: Node) {
        children.append(node)
    }
    
    public func makeIterator() -> AnyIterator<Node> {
        var index = 0
        return AnyIterator { () -> Node? in
            if index >= self.count {
                return nil
            }
            let node = self[index]
            index += 1
            return node
        }
    }
}
