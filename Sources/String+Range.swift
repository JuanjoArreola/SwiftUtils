//
//  String+Range.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public extension String {
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from..<to
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        let location = utf16.distance(from: utf16.startIndex, to: from)
        let length = utf16.distance(from: from, to: to)
        return NSRange(location: location, length: length)
    }
    
    var wholeRange: Range<String.Index> {
        return startIndex..<endIndex
    }
    
    var wholeNSRange: NSRange {
        return NSRange(location: 0, length: characters.count)
    }
}
