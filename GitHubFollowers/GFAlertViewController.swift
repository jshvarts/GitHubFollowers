//
//  GFAlertViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/23/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class GFAlertViewController: UIViewController {
  
  let containerView = UIView()
  let titleLabel = GFTitleLabel(texAlignment: .center, fontSize: 20)
  let messageLabel = GFBodyLabel(texAlignment: .center)
  let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
  
  var alertTitle: String?
  var message: String?
  var buttonTitle: String?
  
  init(title: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = title
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    configureContainerView()
  }
  
  private func configureContainerView() {
    view.addSubview(containerView)
    containerView.backgroundColor = .systemBackground
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 2
    containerView.layer.borderColor = UIColor.white.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220)
    ])
  }
  
  private func configureTitleView() {
    containerView.addSubview(titleLabel)
    titleLabel.text = alertTitle ?? "Something went wrong"
  }
}
