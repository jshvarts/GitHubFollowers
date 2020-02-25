//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/24/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

extension UIViewController {
  func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
      alertViewController.modalPresentationStyle = .overFullScreen
      alertViewController.modalTransitionStyle = .crossDissolve
      self.present(alertViewController, animated: true) // for GCD closures and UIView animate closures, you don't have to do the weak self stuff
    }
  }
}
