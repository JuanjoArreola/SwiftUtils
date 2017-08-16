//
//  FormController.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public protocol FormController: UITextFieldDelegate {
    var textFields: [UITextField]! { get }
    
    var placeholderColor: UIColor { get }
    var placeholderHighlightColor: UIColor { get }
    var errorColor: UIColor { get }
    
    func goAction(_ sender: AnyObject)
    func sendAction(_ sender: AnyObject)
    func highlightEmptyTextFields(_ highlight: Bool)
    func higlightIncorrectTextFields(_ errorTextFields: [UITextField])
    func formTextFieldShouldReturn(_ textField: UITextField) -> Bool
}

public extension FormController {
    
    var errorColor: UIColor {
        return UIColor.red
    }
    var placeholderColor: UIColor {
        return UIColor.lightGray
    }
    var placeholderHighlightColor: UIColor {
        return UIColor.yellow
    }
    
    func formTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done || textField.returnKeyType == .default {
            DispatchQueue.main.async(execute: {
                textField.resignFirstResponder()
            })
        } else if textField.returnKeyType == .go {
            goAction(textField)
            DispatchQueue.main.async(execute: {
                textField.resignFirstResponder()
            })
            return false
        } else if textField.returnKeyType == .send {
            sendAction(textField)
            DispatchQueue.main.async(execute: {
                textField.resignFirstResponder()
            })
            return false
        } else if textField.returnKeyType != .next {
            return true
        }
        guard let start = textFields.index(where: { $0 == textField })?.advanced(by: 1) else {
            return true
        }
        for field in textFields.suffix(from: start) {
            if field.isEnabled {
                field.becomeFirstResponder()
                break
            }
        }
        return true
    }
    
    func highlightEmptyTextFields(_ highlight: Bool) {
        let color = highlight ? placeholderHighlightColor : placeholderColor
        textFields.forEach({ $0.attributedPlaceholder = NSAttributedString(string: $0.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: color])})
    }
    
    func higlightIncorrectTextFields(_ errorTextFields: [UITextField]) {
        errorTextFields.forEach { $0.textColor = errorColor }
    }
    
    func goAction(_ sender: AnyObject) {}
    
    func sendAction(_ sender: AnyObject) {}
}
