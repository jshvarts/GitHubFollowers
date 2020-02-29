//
//  FollowersViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/23/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
  // enums are Hashable by default
  enum Section {
    case main
  }
  
  var username: String!
  var followers: [Follower] = []
  var filteredFollowers: [Follower] = []
  var page = 1
  var hasMoreFollowers = true
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>! // force unwrapping since we'll set it in viewDidLoad()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    configureSearchController()
    getFollowers(username: username, page: page)
    configureDataSource()
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
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
  }
  
  private func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "search for a username"
    navigationItem.searchController = searchController
  }
  
  private func getFollowers(username: String, page: Int) {
    showLoadingView()
    // [weak self] aka capture list in closure to avoid memory leaks
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadingView()
      
      switch result {
      case .success(let followers):
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        // isEmpty is more efficient than .count == 0
        if self.followers.isEmpty {
          let message = "This user does not have any followers. Go follow them 😄"
          self.showEmptyStateView(with: message, in: self.view)
          return
        }
        
        self.updateData(on: self.followers)
        
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
      cell.set(follower: follower)
      return cell
    })
  }
  
  private func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
}

extension FollowersViewController: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    
    if offsetY > contentHeight - height {
      guard hasMoreFollowers else {
        print("no more followers")
        return
        
      }
      page += 1
      getFollowers(username: username, page: page)
    }
  }
}

extension FollowersViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
    filteredFollowers = followers.filter {
      $0.login.lowercased().contains(filter.lowercased())
    }
    updateData(on: filteredFollowers)
  }
}
