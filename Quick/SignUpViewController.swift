//
//  SignUpViewController.swift
//  QuickLoginViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol SignUpViewControllerDelegate: class {
  func signUpDetailsEntered(viewController: SignUpViewController,
                            email: String,
                            fullname: String,
                            password: String)
}
class SignUpViewController: QuickViewController {
  
  weak var delegate: SignUpViewControllerDelegate?
  private var emailTextField: QTextField!
  private var fullnameTextField: QTextField!
  private var passwordTextField: QTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let logoImageView = UIImageView(frame: CGRectMake(130.00, 55.00, 80, 80))
    logoImageView.image = UIImage(named: "Logo")
    self.view.addSubview(logoImageView)
    
    // Add email textfield
    self.emailTextField = QTextField(frame: CGRectMake(20.00, 200.00, 300.0, 50.0),
                                     fontAwesome: String.fontAwesomeIconWithCode("fa-envelope")!)
    emailTextField.field?.placeholder = "Email"
    self.view.addSubview(self.emailTextField)
    
    // Add fullname textfield
    self.fullnameTextField = QTextField(frame: CGRectMake(20.00, 270.00, 300.0, 50.0),
                                        fontAwesome: String.fontAwesomeIconWithCode("fa-user")!);
    self.fullnameTextField.field?.placeholder = "Full Name"
    self.view.addSubview(self.fullnameTextField)
    
    // Add password textfield
    self.passwordTextField = QTextField(frame: CGRectMake(20.00, 340.00, 300.0, 50.0),
                                        fontAwesome: String.fontAwesomeIconWithCode("fa-lock")!);
    passwordTextField.field?.placeholder = "Password"
    passwordTextField.field?.secureTextEntry = true
    self.view.addSubview(self.passwordTextField)
    
    let qButton = QButton(frame: CGRectMake(20.0, 410.0, 300.0, 50.0))
    qButton.addTarget(self, action: #selector(SignUpViewController.notifyDelegate), forControlEvents: .TouchUpInside)
    qButton.setTitle("SIGN UP", forState: .Normal)
    qButton.addTextSpacing(2.0)
    self.view.addSubview(qButton)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  /// Notify delegate of details entered by user.
  @objc private func notifyDelegate() {
    var email: String?
    var fullname: String?
    var password: String?
    
    if let efield = self.emailTextField.field {
      if efield.text != nil {
        email = efield.text
      }
    }
    if let ffield = self.fullnameTextField.field {
      if ffield.text != nil {
        fullname = ffield.text
      }
    }
    if let pfield = self.passwordTextField.field {
      if pfield.text != nil {
        password = pfield.text
      }
    }
    if email!.isEmpty || fullname!.isEmpty || password!.isEmpty {
      return super.displayMessage(title: "Error", message: "Please fill in all fields")
    }
    else if let delegate = self.delegate {
      delegate.signUpDetailsEntered(self, email: email!, fullname: fullname!, password: password!)
    }
  }
}
