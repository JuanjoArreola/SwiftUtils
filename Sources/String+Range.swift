//
//  String+Range.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public extension String {
    
    var wholeRange: Range<String.Index> {
        return startIndex..<endIndex
    }
    
    var wholeNSRange: NSRange {
        return NSRange(location: 0, length: count)
    }
}
