//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/1/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import Foundation

enum PersistenceManager {
  static private let defaults = UserDefaults.standard
  
  enum PersistanceActionType {
    case add, remove
  }
  
  enum Keys {
    static let favorites = "favorites"
  }
  
  static func updateWidth(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GFError?) -> Void) {
    retrieveFavorites { result in
      switch result {
      case .success(var favorites):
        switch actionType {
        case .add:
          guard !favorites.contains(favorite) else {
            return completed(.alreadyInFavorites)
          }
          
          favorites.append(favorite)
          
        case .remove:
          favorites.removeAll { $0.login == favorite.login }
        }
        
        completed(save(favorites: favorites))
        
      case .failure(let error):
        completed(error)
      }
    }
  }
  
  
  static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
    guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
      return completed(.success([]))
    }
    
    do {
      let decoder = JSONDecoder() // Codable was introduced in Swift 4.2
      let favorites = try decoder.decode([Follower].self, from: favoritesData)
      completed(.success(favorites))
    } catch {
      completed(.failure(.unableToFavorite))
    }
  }
  
  static func save(favorites: [Follower]) -> GFError? {
    do {
      let encoder = JSONEncoder()
      let encodedFavorites = try encoder.encode(favorites)
      defaults.set(encodedFavorites, forKey: Keys.favorites)
      return nil
    } catch {
      return .unableToFavorite
    }
  }
}
