//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/4/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
}
