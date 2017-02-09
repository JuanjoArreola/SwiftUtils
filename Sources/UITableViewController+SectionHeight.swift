//
//  UITableViewController+SectionHeight.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public extension UITableView {
    func height(forSections sections: [Int]) -> CGFloat {
        return sections.map({ self.rect(forSection: $0).height }).reduce(0, +)
    }
}
