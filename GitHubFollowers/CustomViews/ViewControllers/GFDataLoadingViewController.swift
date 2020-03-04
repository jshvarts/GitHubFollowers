//
//  GFDataLoadingViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/3/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class GFDataLoadingViewController: UIViewController {
  
  var containerView: UIView!
  
  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)
    
    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0
    
    UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
    ])
    activityIndicator.startAnimating()
  }
  
  func dismissLoadingView() {
    DispatchQueue.main.async {
      self.containerView.removeFromSuperview()
      self.containerView = nil
    }
  }
  
  func showEmptyStateView(with message: String, in view: UIView) {
    DispatchQueue.main.async {
      let emptyStateView = GFEmptyStateView(message: message)
      emptyStateView.frame = view.bounds
      view.addSubview(emptyStateView)
    }
  }
}
