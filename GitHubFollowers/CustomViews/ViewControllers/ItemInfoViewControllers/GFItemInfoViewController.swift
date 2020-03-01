//
//  GFItemInfoViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/29/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class GFItemInfoViewController: UIViewController {
  
  let stackView = UIStackView()
  let itemInfoViewOne = GFItemInfoView()
  let itemInfoViewTwo = GFItemInfoView()
  let actionButton = GFButton()
  
  var user: User!
  var delegate: UserInfoViewControllerDelegate!
  
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureBackgroundView()
    configureActionButton()
    configureStackView()
    layoutUI()
  }
  
  private func configureBackgroundView() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
  }
  
  private func configureStackView() {
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    
    // note usage of addArrangedView
    stackView.addArrangedSubview(itemInfoViewOne)
    stackView.addArrangedSubview(itemInfoViewTwo)
  }
  
  private func configureActionButton() {
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
  }
  
  @objc func actionButtonTapped() {} // to be overriden by subsclasses
  
  private func layoutUI() {
    view.addSubview(stackView)
    view.addSubview(actionButton)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
      
    ])
  }
}
