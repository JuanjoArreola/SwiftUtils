//
//  ButtonSelectGroup.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 26/12/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public struct ButtonSelectGroup<T: Equatable> {
    var buttons = [UIButton: T]()
    
    public init() {}
    
    public mutating func add(button: UIButton, value: T) {
        buttons[button] = value
    }
    
    public func didSelect(button: UIButton) {
        button.isSelected = !button.isSelected
        buttons.keys.forEach({ if $0 != button { $0.isSelected = false } })
    }
    
    public func doSelect(option: T?) {
        if let result = buttons.first(where: { $0.value == option }) {
            didSelect(button: result.key)
        } else {
            buttons.keys.forEach({ $0.isSelected = false })
        }
    }
    
    public var value: T? {
        return buttons.first(where: { $0.key.isSelected })?.value
    }
    
    public func contains(button: UIButton) -> Bool {
        return buttons.keys.contains(button)
    }
    
}

public extension ButtonSelectGroup where T == Bool {
    init(trueButton: UIButton, falseButton: UIButton) {
        add(button: trueButton, value: true)
        add(button: falseButton, value: false)
    }
}
