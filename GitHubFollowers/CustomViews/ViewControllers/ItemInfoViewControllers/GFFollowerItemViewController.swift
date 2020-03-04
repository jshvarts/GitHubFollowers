//
//  GFFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/1/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

protocol GFFollowerViewControllerDelegate: class {
  func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
  
  private weak var delegate: GFFollowerViewControllerDelegate!
  
  init(user: User, delegate: GFFollowerViewControllerDelegate) {
    super.init(user: user)
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  override func actionButtonTapped() {
    delegate.didTapGetFollowers(for: user)
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
}
