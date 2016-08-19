//
//  SignUpViewController.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class SignUpViewController: QuickViewController {
  
  
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var firstnameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var lastnameTextField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  @IBAction func signUp(sender: AnyObject) {
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
        // Present home viewcontroller to log user in.
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = sb.instantiateViewControllerWithIdentifier("HomeViewController")
        self.navigationController?.pushViewController(homeViewController, animated: true)
      } else {
        return super.displayMessage(title: "Error", message: "An error occurred trying to sign up.")
      }
    }
  }
  
  
  private func validInputFields() -> Bool {
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
