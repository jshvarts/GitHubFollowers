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
  var logoImageViewTopConstraint: NSLayoutConstraint!
  
  var isUsernameEntered: Bool { !usernameTextField.text!.isEmpty }
  
  // hide navigation bar every time screen is displayed not when it loaded initially in viewDidLoad
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
    usernameTextField.text = ""
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground // white for light mode, black for dark mode
    view.addSubviews(logoImageView, usernameTextField, callToActionButton)
    configureLogoImageView()
    configureTextField()
    configureCallToActionButton()
    createDismissKeyboardTabGesture()
  }
  
  private func createDismissKeyboardTabGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tap)
  }
  
  private func configureLogoImageView() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = Images.ghLogo
    
    let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
    
    // each view generally needs 4 constraints
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  private func configureTextField() {
    usernameTextField.delegate = self
    
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), // trailing and bottom constraints use negative values
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func configureCallToActionButton() {
    callToActionButton.addTarget(self, action: #selector(pushFollowersViewController), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  // invoked in case go is tapped or Get Followers is tapped
  @objc private func pushFollowersViewController() {
    guard isUsernameEntered else {
      presentGFAlert(title: "Empty username", message: "Please enter username. We need to know who to look for 😀", buttonTitle: "Ok")
      return
    }
    
    usernameTextField.resignFirstResponder()
    
    let followersViewController = FollowersViewController(username: usernameTextField.text!)
    navigationController?.pushViewController(followersViewController, animated: true)
  }
}

extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    usernameTextField.resignFirstResponder()
    pushFollowersViewController()
    return true
  }
}
