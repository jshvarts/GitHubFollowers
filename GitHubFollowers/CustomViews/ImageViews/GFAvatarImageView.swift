//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/26/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
  let cache = NetworkManager.shared.cache
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = Images.placeholder
    translatesAutoresizingMaskIntoConstraints = false
  }
}
