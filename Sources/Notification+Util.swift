//
//  Notification+Util.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 11/05/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import Foundation

public extension Notification {
    var keyboardAnimationDuration: Double? {
        return userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
    }
    
    var keyboardFrameEnd: CGRect? {
        return (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
}

public extension Notification.Name {
    
    func post(object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: self, object: object, userInfo: userInfo)
    }
    
    func observe(object: Any? = nil, _ closure: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: self, object: object, queue: nil, using: closure)
    }
}
