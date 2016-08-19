//
//  LoginViewController.swift
//  Quick
//
//  Created by Stephen Fox on 19/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class LoginViewController: QuickViewController {
  
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  
  override func viewDidLoad() {
    
  }
  
  
  @IBAction func login(sender: AnyObject) {
    guard self.validInputFields() else {
      return super.displayMessage(title: "Error", message: "Please fill in all fields")
    }
    
    // Create user object.
    let user = User()
    user.email = self.emailTextField.text!
    user.password = self.passwordTextField.text!
    
    // Attempt to login.
    let loginManager = LoginManager.sharedInstance
    loginManager.login(user) { (success, session) in
      if success {
        // Present home viewcontroller to log user in.
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = sb.instantiateViewControllerWithIdentifier("HomeViewController")
        self.navigationController?.pushViewController(homeViewController, animated: true)
      } else {
        return super.displayMessage(title: "Error", message: "Invalid Credentials")
      }
    }
  }
  
  private func validInputFields() -> Bool {
    if self.emailTextField.text!.isEmpty ||
       self.passwordTextField.text!.isEmpty {
      return false
    } else {
      return true
    }
  }
  
}
