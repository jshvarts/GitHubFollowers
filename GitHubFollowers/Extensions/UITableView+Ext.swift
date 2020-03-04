//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/4/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

extension UITableView {
  
  // unused but may be useful in other projects
  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
  
  // remove empty cells
  func removeExcessCells() {
    tableFooterView = UIView(frame: .zero)
  }
}
