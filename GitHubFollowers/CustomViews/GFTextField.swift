//
//  GFTextField.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/23/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray4.cgColor // layer requires cg color (use semantic app to see what color works in light/dark modes)
 
    textColor = .label // black in light mode and white in dark mode
    tintColor = .label // blinking cursor color
    textAlignment = .center
    font = UIFont.preferredFont(forTextStyle: .title2) // dynamic font
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 12
    autocapitalizationType = .none
    
    backgroundColor = .tertiarySystemBackground
    autocorrectionType = .no
    returnKeyType = .go
    
    placeholder = "Enter a username"
  }
}
