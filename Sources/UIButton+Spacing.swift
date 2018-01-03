//
//  UIButton+Spacing.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 26/12/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public extension UIButton {
    
    func setSpacing(_ spacing: CGFloat, margin: CGFloat) {
        let space = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -space + margin, bottom: 0, right: space)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: space + margin, bottom: 0, right: -space - margin)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space + margin + margin)
    }
}
