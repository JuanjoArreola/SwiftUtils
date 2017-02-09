//
//  UIViewController+Alert.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach({ alert.addAction($0) })
        if actions?.isEmpty ?? true {
            alert.addAction(UIAlertAction(title: "Accept".localized, style: .default, handler: nil))
        }
        present(alert, animated: true, completion: nil)
    }
}
