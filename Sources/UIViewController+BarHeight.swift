//
//  UIViewController+BarHeight.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public extension UIViewController {
    var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.bounds.height ?? 0
    }
    
    var statusBarHeight: CGFloat {
        return min(UIApplication.shared.statusBarFrame.height, 20)
    }
    
    var topBarsHeight: CGFloat {
        return navigationBarHeight + statusBarHeight
    }
    
    var tabBarHeight: CGFloat {
        if tabBarController?.tabBar.isHidden ?? true { return 0 }
        return tabBarController?.tabBar.bounds.size.height ?? 0
    }
    
    var safeAreaTopHeight: CGFloat {
        let height = navigationController?.navigationBar.subviews[0].bounds.height
        if #available(iOS 11.0, *) {
            return height ?? view.safeAreaInsets.top
        } else {
            return height ?? 0
        }
    }
    
    var safeAreaBottomHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return 0
        }
    }
    
    var safeAreaHeight: CGFloat {
        return safeAreaTopHeight + safeAreaBottomHeight
    }
}
