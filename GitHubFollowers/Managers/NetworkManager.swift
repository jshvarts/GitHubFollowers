//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/24/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  let baseURL = "https://api.github.com/users/"
  
  private init() {}
  
  func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    
    guard let url = URL(string: endpoint) else {
      completed(nil, .invalidUsername)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completed(nil, .unableToComplete)
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(nil, .invalidResponse)
        return
      }

      guard let data = data else {
        completed(nil, .invalidData)
        return
      }
      
      do {
        let decoder = JSONDecoder() // Codable was introduced in Swift 4.2
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let followers = try decoder.decode([Follower].self, from: data)
        completed(followers, nil)
      } catch {
        // developers can use error.localizedDescription for more detail
        completed(nil, .invalidData)
      }
    }

    task.resume()
  }
}
