//
//  Selectable.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 26/12/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public class Selectable<T> {
    public var item: T
    public var isSelected = false
    
    public init(_ item: T, selected: Bool = false) {
        self.item = item
        self.isSelected = selected
    }
}
