//
//  String+Localization.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedWithComment(_ comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(arguments: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
    
    func localized(attributes: [NSAttributedStringKey: Any]?, arguments: [NSAttributedString]) -> NSAttributedString {
        let string = NSLocalizedString(self, comment: "")
        let components = string.components(separatedBy: "%@")
        if components.count - 1 != arguments.count || components.isEmpty {
            return NSAttributedString(string: string)
        }
        let result = NSMutableAttributedString(string: components[0], attributes: attributes)
        for (index, argument) in arguments.enumerated() {
            result.append(argument)
            result.append(NSAttributedString(string: components[index + 1], attributes: attributes))
        }
        return result
    }
}
