//
//  GFError.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/29/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import Foundation

// conforms to the Error protocol
enum GFError: String, Error {
  case invalidUsername = "This username created an invalid url. Please try again"
  case unableToComplete = "Unable to complete request. Check your internet connection"
  case invalidResponse = "Invalid response from the server. Please try again"
  case invalidData = "Invalid data from the server. Please try again"
}
