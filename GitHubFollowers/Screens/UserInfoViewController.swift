//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/29/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
  func didTapGitHubProfile(for user: User)
  func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController {
  
  let headerView = UIView()
  let itemViewOne = UIView()
  let itemViewTwo = UIView()
  let dateLabel = GFBodyLabel(textAlignment: .center)
  var itemViews: [UIView] = []
  
  var username: String!
  weak var delegate: FollowersViewControllerDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    layoutUI()
    getUserInfo()
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  private func getUserInfo() {
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        self.configureUIElements(with: user)
        
      case .failure(let error):
        self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        break
      }
    }
  }
  
  private func configureUIElements(with user: User) {
    DispatchQueue.main.async {
      let repoViewController = GFRepoItemViewController(user: user)
      repoViewController.delegate = self
      
      let followerViewController = GFFollowerItemViewController(user: user)
      followerViewController.delegate = self
      
      self.add(childViewController: repoViewController, to: self.itemViewOne)
      self.add(childViewController: followerViewController, to: self.itemViewTwo)
      self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
      self.dateLabel.text = "GitHub member since \(user.createdAt.convertToMonthYearFormat())"
    }
  }
  
  @objc private func dismissViewController() {
    dismiss(animated: true)
  }
  
  private func add(childViewController: UIViewController, to containerView: UIView) {
    addChild(childViewController)
    containerView.addSubview(childViewController.view)
    childViewController.view.frame = containerView.bounds
    childViewController.didMove(toParent: self)
  }
  
  private func layoutUI() {
    let padding: CGFloat = 20
    let margin: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
    
    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
      ])
    }
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: margin),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: margin),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
      
      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: margin),
      dateLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
}

extension UserInfoViewController: UserInfoViewControllerDelegate {
  func didTapGitHubProfile(for user: User) {
    guard let profileUrl = URL(string: user.htmlUrl) else {
      return self.presentGFAlert(title: "Inalid URL", message: "The URL attached to this user is invalid", buttonTitle: "Ok")
    }
    
    presentSafariViewController(with: profileUrl)
  }
  
  func didTapGetFollowers(for user: User) {
    guard user.followers != 0 else {
      return self.presentGFAlert(title: "No followers", message: "This user has no followers 😞", buttonTitle: "Ok")
    }
    delegate.didRequestFollowers(for: user.login)
    dismissViewController()
  }
}
