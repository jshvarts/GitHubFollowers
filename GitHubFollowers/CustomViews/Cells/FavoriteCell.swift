//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/1/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
  static let reuseId = "FavoriteCell"
  
  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(favorite: Follower) {
    usernameLabel.text = favorite.login
    avatarImageView.downloadImage(from: favorite.avatarUrl  )
  }
  
  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)
    accessoryType = .disclosureIndicator
    
    avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let padding: CGFloat = 12
    let avatarWidth: CGFloat = 60
    
    NSLayoutConstraint.activate([
      avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
      avatarImageView.heightAnchor.constraint(equalToConstant: avatarWidth),
      avatarImageView.widthAnchor.constraint(equalToConstant: avatarWidth),
      
      usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
      usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
