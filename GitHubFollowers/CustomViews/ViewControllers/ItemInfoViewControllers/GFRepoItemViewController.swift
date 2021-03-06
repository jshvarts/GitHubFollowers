//
//  GFRepoItemViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/1/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: class {
  func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
  
  // delegates should be weak to avoid retain cycles
  private weak var delegate: GFRepoItemViewControllerDelegate!
  
  init(user: User, delegate: GFRepoItemViewControllerDelegate) {
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
    delegate.didTapGitHubProfile(for: user)
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
  }
}
