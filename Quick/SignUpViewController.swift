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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func signUp(sender: AnyObject) {
    guard validInputFields() else {
      return super.displayMessage(title: "Error", message: "Please fill in all fields")
    }
    
    let signUpManager = SignUpManager.sharedInstace
    let user = User(email: self.emailTextField.text!,
                    firstname: self.firstnameTextField.text!,
                    lastname: self.passwordTextField.text!,
                    password: self.lastnameTextField.text!)
    
    signUpManager.createUserAccount(user) { (success) in
      return super.displayMessage(title: "Success", message: "Account created")
    }
    
  }
  
  
  private func validInputFields() -> Bool {
    if (self.emailTextField.text!.isEmpty ||
        self.firstnameTextField.text!.isEmpty ||
        self.passwordTextField.text!.isEmpty ||
        self.lastnameTextField.text!.isEmpty) {
      return false
    } else {
      return true
    }
  }
}
