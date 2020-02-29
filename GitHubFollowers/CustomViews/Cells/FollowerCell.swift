//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/26/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  static let reuseId = "FollowerCell"
  
  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(follower: Follower) {
    usernameLabel.text = follower.login
    avatarImageView.downloadImage(from: follower.avatarUrl  )
  }
  
  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)
    
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      // all cells have contentView
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
      
      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: padding),
      usernameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
