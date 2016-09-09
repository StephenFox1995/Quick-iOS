//
//  LoginViewController.swift
//  QuickLoginViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol LoginViewControllerDelegate: class {
  func loginDetailsEntered(viewController: LoginViewController, email: String, password: String)
}

class LoginViewController: QuickViewController {
  
  private var emailTextField: QTextField!
  private var passwordTextField: QTextField!
  weak var delegate: LoginViewControllerDelegate? 
  
  override func viewDidLoad() {
    super.viewDidLoad()

    
    let qButton = QButton(frame: CGRectMake(20.0, 350.0, 300.0, 50.0))
    qButton.setTitle("LOGIN", forState: .Normal)
    qButton.addTextSpacing(2.0)
    qButton.addTarget(self, action: #selector(LoginViewController.notifyDelegate), forControlEvents: .TouchUpInside)
    self.view.addSubview(qButton)
    
    self.emailTextField = QTextField(frame: CGRectMake(20.00, 200.00, 300.0, 50.0),
                                    fontAwesome: String.fontAwesomeIconWithCode("fa-envelope")!)
    self.emailTextField.field?.placeholder = "Email"
    self.emailTextField.field?.autocorrectionType = .No
    self.emailTextField.field?.autocapitalizationType = .None
    self.view.addSubview(self.emailTextField)
    
    self.passwordTextField = QTextField(frame: CGRectMake(20.00, 270.00, 300.0, 50.0),
                                        fontAwesome: String.fontAwesomeIconWithCode("fa-lock")!);
    self.passwordTextField.field?.placeholder = "Password"
    self.passwordTextField.field?.secureTextEntry = true
    
    self.view.addSubview(self.passwordTextField)
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
