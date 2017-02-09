//
//  CGPoint+ArithmeticOperators.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

public func +(first: CGPoint, second: CGPoint) -> CGPoint {
    return CGPoint(x: first.x + second.x, y: first.y + second.y)
}

public func -(first: CGPoint, second: CGPoint) -> CGPoint {
    return CGPoint(x: first.x - second.x, y: first.y - second.y)
}
