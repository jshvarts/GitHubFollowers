//
//  FavoritesViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/22/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBlue
    
    PersistenceManager.retrieveFavorites { result in
      switch result {
      case .success(let favorites):
        print("success! \(favorites)")
      case .failure(let error):
        print("error! \(error)")
      }
    }
  }
}
