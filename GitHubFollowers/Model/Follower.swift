//
//  Follower.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/24/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
  var login: String
  var avatarUrl: String // Codable decoder will convert snake case to camel case
}
