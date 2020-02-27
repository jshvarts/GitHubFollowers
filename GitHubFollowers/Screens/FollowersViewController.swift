//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/23/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
  
  var username: String!
  var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureCollectionView() {
    // fill up the view (use view.bounds)
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemPink
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
  }
  
  private func getFollowers() {
    NetworkManager.shared.getFollowers(for: username, page: 1) { result in
      switch result {
      case .success(let followers):
        print("followers: \(followers)")
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
}
