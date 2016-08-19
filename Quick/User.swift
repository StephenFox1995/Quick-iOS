//
//  User.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class User: Account {
  override init() {
    super.init()
  }
  
  init(email: String,
       firstname: String,
       lastname: String,
       password: String?) {
    super.init()
    self.email = email
    self.firstname = firstname
    self.lastname = lastname
    self.password = password
  }
}
