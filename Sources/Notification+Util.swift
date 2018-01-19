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
    
    func post(userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: self, object: nil, userInfo: userInfo)
    }
    
    func observe(_ closure: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: self, object: nil, queue: nil, using: closure)
    }
}
