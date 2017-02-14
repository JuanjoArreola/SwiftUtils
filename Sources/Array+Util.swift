//
//  Array+Util.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public extension Array {
    func find(_ criteria: (_ element: Element) -> Bool) -> Element? {
        for element in self {
            if criteria(element) {
                return element
            }
        }
        return nil
    }
}

public extension Array where Element: Equatable {
    
    mutating func removeElement(_ element: Element) -> Element? {
        if let index = index(of: element) {
            return remove(at: index)
        }
        return nil
    }
    
    mutating func removeAllOccurrences(of element: Element) -> Int {
        var occurrences = 0
        while true {
            if let index = index(of: element) {
                remove(at: index)
                occurrences += 1
            } else {
                return occurrences
            }
        }
    }
    
}
