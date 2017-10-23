//
//  String+Email.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

let emailRegex = try! NSRegularExpression(pattern: "\\A.+@.+\\.[A-Za-z0-9]{2,}\\Z", options: [])

public extension String {
    var isPossibleEmail: Bool {
        return emailRegex.numberOfMatches(in: self, options: [], range: NSMakeRange(0, count)) > 0
    }
}
