//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/22/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class FavoritesViewController: GFDataLoadingViewController {
  
  let tableView = UITableView()
  var favorites: [Follower] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavorites()
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    title = "Favorites"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureTableView() {
    view.addSubview(tableView)
    
    tableView.frame = view.bounds
    tableView.rowHeight = 80
    tableView.delegate = self
    tableView.dataSource = self
    tableView.removeExcessCells()
    
    tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
  }
  
  func getFavorites() {
    PersistenceManager.retrieveFavorites { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let favorites):
        if favorites.isEmpty {
          self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
        } else {
          self.favorites = favorites
          DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
          }
        }
        
      case .failure(let error):
        self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // this could be extracted in its own data source if it was more complex
    let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
    let favorite = favorites[indexPath.row]
    cell.set(favorite: favorite)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let favorite = favorites[indexPath.row]
    let desinationViewController = FollowersViewController(username: favorite.login)
    navigationController?.pushViewController(desinationViewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    
    let favorite = favorites[indexPath.row]
    favorites.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .left)
    
    PersistenceManager.updateWidth(favorite: favorite, actionType: .remove) { [weak self] error in
      guard let self = self else { return }
      
      guard let error = error else { return }
      
      self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
    }
  }
}
