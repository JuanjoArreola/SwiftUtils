//
//  UIView+Util.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 16/08/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 1.0) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        if let color = borderColor?.cgColor {
            self.layer.borderColor = color
            self.layer.borderWidth = borderWidth
        }
    }
}
