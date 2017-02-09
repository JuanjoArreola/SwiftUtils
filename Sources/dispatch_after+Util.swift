//
//  dispatch_after+Util.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public func dispatch_after(seconds: Double, queue: DispatchQueue, closure: @escaping () -> Void) {
    queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(seconds * 1000) * Int64(NSEC_PER_MSEC)) / Double(NSEC_PER_SEC), execute: closure)
}

public func dispatch_after(milliseconds: Int64, queue: DispatchQueue, closure: @escaping () -> Void) {
    queue.asyncAfter(deadline: DispatchTime.now() + Double(milliseconds * Int64(NSEC_PER_MSEC)) / Double(NSEC_PER_SEC), execute: closure)
}

public func dispatch_after(nanoseconds: Int64, queue: DispatchQueue, closure: @escaping () -> Void) {
    queue.asyncAfter(deadline: DispatchTime.now() + Double(nanoseconds) / Double(NSEC_PER_SEC), execute: closure)
}
