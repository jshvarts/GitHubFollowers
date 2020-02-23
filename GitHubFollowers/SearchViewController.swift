//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 2/22/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  let logoImageView = UIImageView()
  let usernameTextField = GFTextField()
  let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
  
  // hide navigation bar every time screen is displayed not when it loaded initially in viewDidLoad
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground // white for light mode, black for dark mode
    configureLogoImageView()
    configureTextField()
    configureCallToActionButton()
    createDismissKeyboardTabGesture()
  }
  
  private func createDismissKeyboardTabGesture() {
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tap)
  }
  
  private func configureLogoImageView() {
    view.addSubview(logoImageView)
    
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = UIImage(named: "gh-logo") // beware of stringly-typed
    
    // each view generally needs 4 constraints
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  private func configureTextField() {
    view.addSubview(usernameTextField)
    usernameTextField.delegate = self
    
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), // trailing and bottom constraints use negative values
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func configureCallToActionButton() {
    view.addSubview(callToActionButton)
    
    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print("should return")
    return true
  }
}
