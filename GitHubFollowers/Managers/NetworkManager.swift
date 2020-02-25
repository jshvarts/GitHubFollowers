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
  
  func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    
    guard let url = URL(string: endpoint) else {
      completed(nil, "This username created an invalid url. Please try again")
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completed(nil, "Unable to complete request. Check your internet connection")
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(nil, "Invalid response from the server. Please try again")
        return
      }

      guard let data = data else {
        completed(nil, "Invalid data from the server. Please try again")
        return
      }
      
      do {
        let decoder = JSONDecoder() // Codable was introduced in Swift 4.2
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let followers = try decoder.decode([Follower].self, from: data)
        completed(followers, nil)
      } catch {
        completed(nil, "Invalid data from the server. Please try again")
      }
    }

    task.resume()
  }
}
