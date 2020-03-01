//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/29/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
  
  var username:String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
    navigationItem.rightBarButtonItem = doneButton
    
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        print("user: \(user)")
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        break
      }
    }
  }
  
  @objc private func dismissViewController() {
    dismiss(animated: true)
  }
}
