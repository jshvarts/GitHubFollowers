//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/23/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class GFButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(backgroundColor: UIColor, title: String) {
    self.init(frame: .zero) // we will control button placement using auto layout constraints instead
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
  }
  
  // used by the Storyboard
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(backgroundColor: UIColor, title: String) {
    self.backgroundColor = backgroundColor
    setTitle(title, for: .normal)
  }
  
  private func configure() {
    layer.cornerRadius = 10
    setTitleColor(.white, for: .normal)
    
    // font scaled for the user's preferred font size
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    
    // necessary to enable auto layout later
    translatesAutoresizingMaskIntoConstraints = false
  }
}
