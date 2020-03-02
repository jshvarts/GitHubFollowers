//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/24/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
  func presentGFAlert(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
      alertViewController.modalPresentationStyle = .overFullScreen
      alertViewController.modalTransitionStyle = .crossDissolve
      self.present(alertViewController, animated: true) // for GCD closures and UIView animate closures, you don't have to do the weak self stuff
    }
  }
  
  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)
    
    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0
    
    UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    activityIndicator.startAnimating()
  }
  
  func dismissLoadingView() {
    DispatchQueue.main.async {
      containerView.removeFromSuperview()
      containerView = nil
    }
  }
  
  func showEmptyStateView(with message: String, in view: UIView) {
    DispatchQueue.main.async {
      let emptyStateView = GFEmptyStateView(message: message)
      emptyStateView.frame = view.bounds
      view.addSubview(emptyStateView)
    }
  }
  
  func presentSafariViewController(with url: URL) {
    let safariViewController = SFSafariViewController(url: url)
    safariViewController.preferredBarTintColor = .systemGreen
    present(safariViewController, animated: true)
  }
}
