//
//  dispatch_after+Util.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    
    public func asyncAfter(seconds: Double, closure: @escaping () -> Void) {
        asyncAfter(deadline: DispatchTime.now() + Double(Int64(seconds * 1000) * Int64(NSEC_PER_MSEC)) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    public func asyncAfter(milliseconds: Int64, queue: DispatchQueue, closure: @escaping () -> Void) {
        asyncAfter(deadline: DispatchTime.now() + Double(milliseconds * Int64(NSEC_PER_MSEC)) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    public func asyncAfter(nanoseconds: Int64, queue: DispatchQueue, closure: @escaping () -> Void) {
        asyncAfter(deadline: DispatchTime.now() + Double(nanoseconds) / Double(NSEC_PER_SEC), execute: closure)
    }
}
