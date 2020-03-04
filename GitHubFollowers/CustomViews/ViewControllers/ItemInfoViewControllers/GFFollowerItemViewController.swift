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

  weak var delegate: GFFollowerViewControllerDelegate!

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
