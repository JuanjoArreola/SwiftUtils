//
//  UIView+Util.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 16/08/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public extension UIView {
    func setCornerRadius(_ radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 1.0) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        if let color = borderColor?.cgColor {
            self.layer.borderColor = color
            self.layer.borderWidth = borderWidth
        }
    }
}

public extension UIView {
    
    @available(iOS 9.0, *)
    func center(_ view: UIView, between topView: UIView, and bottomView: UIView) {
        center(view, between: topView, and: bottomView.topAnchor)
    }
    
    @available(iOS 9.0, *)
    func center(_ view: UIView, between topView: UIView, and bottomAnchor: NSLayoutYAxisAnchor) {
        let top = UILayoutGuide()
        let bottom = UILayoutGuide()
        addLayoutGuide(top)
        addLayoutGuide(bottom)
        
        top.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        top.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottom.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottom.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        top.heightAnchor.constraint(equalTo: bottom.heightAnchor).isActive = true
    }
}

public extension UIView {
    
    class func fromNib(_ name: String) -> Self? {
        return fromNib(name: name, type: self)
    }
    
    private class func fromNib<T: UIView>(name: String, type: T.Type) -> T? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[0] as? T
    }
}
