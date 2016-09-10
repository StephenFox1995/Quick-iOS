//
//  LoginViewController.swift
//  QuickLoginViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Cartography

protocol LoginViewControllerDelegate: class {
  func loginDetailsEntered(viewController: LoginViewController, email: String, password: String)
}

class LoginViewController: QuickViewController {
  
  private var emailTextField: QTextField!
  private var passwordTextField: QTextField!
  private var signInButton : QButton!
  weak var delegate: LoginViewControllerDelegate? 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.clearColor()
    self.setUpViews()
  }
  
  private func setUpViews() {    
    self.emailTextField = QTextField(fontAwesome: String.fontAwesomeIconWithCode("fa-envelope")!)
    self.emailTextField.field?.placeholder = "Email"
    self.emailTextField.field?.autocorrectionType = .No
    self.emailTextField.field?.autocapitalizationType = .None
    self.view.addSubview(self.emailTextField)
    
    self.passwordTextField = QTextField(fontAwesome: String.fontAwesomeIconWithCode("fa-lock")!);
    self.passwordTextField.field?.placeholder = "Password"
    self.passwordTextField.field?.secureTextEntry = true
    self.view.addSubview(self.passwordTextField)
    
    self.signInButton = QButton()
    self.signInButton.setTitle("LOGIN", forState: .Normal)
    self.signInButton.addTextSpacing(2.0)
    self.signInButton.addTarget(self,
                                action: #selector(LoginViewController.notifyDelegate),
                                forControlEvents: .TouchUpInside)
    self.view.addSubview(self.signInButton)
    
    constrain(self.view, self.emailTextField, self.passwordTextField, self.signInButton) {
      (superView, emailTextField, passwordTextField, signInButton) in
      emailTextField.centerX == superView.centerX
      emailTextField.top == superView.top + 200
      emailTextField.width == 300
      emailTextField.height == 50
      
      passwordTextField.centerX == superView.centerX
      passwordTextField.top == superView.top + 270
      passwordTextField.width == 300
      passwordTextField.height == 50
      
      signInButton.centerX == superView.centerX
      signInButton.top == superView.top + 350
      signInButton.width == 300
      signInButton.height == 50
      
    }
  }
  
  /// Notify delegate of details entered by user.
  @objc private func notifyDelegate() {
    var email: String?
    var password: String?
    if let efield = self.emailTextField.field { // Check email value
      if efield.text != nil {
        email = efield.text
      }
    }
    if let pfield = self.passwordTextField.field { // Check password value
      if pfield.text != nil {
        password = pfield.text
      }
    }
    if email!.isEmpty || password!.isEmpty {
      return super.displayMessage(title: "Error", message: "Please fill in all fields")
    }
    else if let delegate = self.delegate {
      delegate.loginDetailsEntered(self, email: email!, password: password!)
    }
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
}
