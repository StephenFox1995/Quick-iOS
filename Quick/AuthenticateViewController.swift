//
//  SignUpViewController.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 Use this view controller to register users or log users into the app.
 */
class AuthenticateViewController: QuickViewController {
  
  /// Authenticate mode of this viewcontroller
  private enum AuthMode {
    case SignUp
    case Login
  }
  
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var firstnameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var lastnameTextField: UITextField!
  @IBOutlet weak var authButton: UIButton!
  private var authMode: AuthMode = .Login
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.determineAuthMode()
  }
  
  
  private func determineAuthMode() {
    if self.authMode == .Login {
      self.firstnameTextField.hidden = true
      self.lastnameTextField.hidden = true
    } else {
      self.firstnameTextField.hidden = false
      self.lastnameTextField.hidden = false
    }
  }
  
  /// Sign user up to app.
  @IBAction func signUp() {
    guard self.validInputFields() else {
      return super.displayMessage(title: "Error", message: "Please fill in all fields")
    }
    
    let signUpManager = SignUpManager.sharedInstace
    let user = User(email: self.emailTextField.text!,
                    firstname: self.firstnameTextField.text!,
                    lastname: self.lastnameTextField.text!,
                    password: self.passwordTextField.text!)
    
    signUpManager.createUserAccount(user) { (success, session) in
      if success {
        self.presentHomeViewController()
      } else {
        return super.displayMessage(title: StringConstants.error, message: StringConstants.accountTaken)
      }
    }
  }
  
  /// Log user in to app.
  @IBAction func login() {
    guard self.validInputFields() else {
      return super.displayMessage(title: StringConstants.error, message: StringConstants.fillInFields)
    }
    
    // Create user object.
    let user = User()
    user.email = self.emailTextField.text!
    user.password = self.passwordTextField.text!
    
    // Attempt to login.
    let loginManager = LoginManager.sharedInstance
    loginManager.login(user) { (success, session) in
      if success {
        self.presentHomeViewController()
      } else {
        return super.displayMessage(title: StringConstants.error, message: StringConstants.invalidCredential)
      }
    }
  }
  
  
  private func presentHomeViewController() {
    // Present home viewcontroller to log user in.
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let homeViewController = sb.instantiateViewControllerWithIdentifier(StringConstants.homeViewController)
    self.navigationController?.pushViewController(homeViewController, animated: false)
  }
  
  private func validInputFields() -> Bool {
    if self.authMode == .Login {
      if self.emailTextField.text!.isEmpty ||
        self.passwordTextField.text!.isEmpty {
        return false
      } else {
        return true
      }
    } else {
      if self.emailTextField.text!.isEmpty ||
        self.firstnameTextField.text!.isEmpty ||
        self.passwordTextField.text!.isEmpty ||
        self.lastnameTextField.text!.isEmpty {
        return false
      } else {
        return true
      }
    }
  }
  
  @IBAction func authButtonPress(sender: AnyObject) {
    if self.authMode == .Login {
      self.login()
    } else {
      self.signUp()
    }
  }
  // Changes the auth button action from
  // sign up to login
  private func changeAuthButtonAction(authMode: AuthMode) {
    switch authMode {
    case .SignUp:
      self.authButton.titleLabel?.text = "Sign Up"
    case .Login:
      self.authButton.titleLabel?.text = "Login"
    }
    self.authMode = authMode
  }
  
  @IBAction func signUpMode(sender: AnyObject) {
    self.changeAuthButtonAction(.SignUp)
    self.authMode = .SignUp
    self.determineAuthMode()
  }
  
  
  @IBAction func loginMode(sender: AnyObject) {
    self.changeAuthButtonAction(.Login)
    self.authMode = .Login
    self.determineAuthMode()
  }

}
