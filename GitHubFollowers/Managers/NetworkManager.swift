//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/24/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  let baseURL = "https://api.github.com/users/"
  let cache = NSCache<NSString, UIImage>()
  
  private init() {}
  
  func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    
    guard let url = URL(string: endpoint) else {
      completed(.failure(.unableToComplete))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder() // Codable was introduced in Swift 4.2
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let followers = try decoder.decode([Follower].self, from: data)
        completed(.success(followers))
      } catch {
        // developers can use error.localizedDescription for more detail
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
  
  func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
    let endpoint = baseURL + "\(username)"
    
    guard let url = URL(string: endpoint) else {
      completed(.failure(.unableToComplete))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder() // Codable was introduced in Swift 4.2
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        let user = try decoder.decode(User.self, from: data)
        completed(.success(user))
      } catch {
        // developers can use error.localizedDescription for more detail
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }
}
