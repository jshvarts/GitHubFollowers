//
//  GFFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/1/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  override func actionButtonTapped() {
    delegate.didTapGetFollowers()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
}
