//
//  String+Range.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public extension String {
    func range(from range: NSRange) -> Range<String.Index>? {
        guard let start = index(startIndex, offsetBy: range.location, limitedBy: endIndex),
            let end = index(start, offsetBy: range.length, limitedBy: endIndex) else { return nil }
        return start..<end
    }
}
