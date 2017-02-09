//
//  UIViewController+ActivityIndicator.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setBarButtonItem(_ item: UIBarButtonItem) {
        navigationItem.rightBarButtonItem = item
    }
    
    func removeBarButtonItem() {
        navigationItem.rightBarButtonItem = nil
    }
    
    func startBarActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        let item = UIBarButtonItem(customView: activityIndicator)
        setBarButtonItem(item)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func stopBarActivityIndicator() {
        (navigationItem.rightBarButtonItem?.customView as? UIActivityIndicatorView)?.stopAnimating()
        (navigationItem.leftBarButtonItem?.customView as? UIActivityIndicatorView)?.stopAnimating()
        removeBarButtonItem()
    }
}
