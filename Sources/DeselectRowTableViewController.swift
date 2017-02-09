//
//  DeselectRowTableViewController.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

open class DeselectRowTableViewController: UITableViewController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
            transitionCoordinator?.notifyWhenInteractionEnds({ (context) in
                if context.isCancelled {
                    self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                }
            })
        }
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.backgroundColor = cell.backgroundColor
        return cell
    }
}

