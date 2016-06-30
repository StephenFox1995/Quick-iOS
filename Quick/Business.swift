//
//  Business.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class Business {
  var id: String?
  var name: String?
  var address: String?
  var contactNumber: String?
  var email: String?
  
  
  init(id: String, name: String, address: String, contactNumber: String, email: String) {
    self.id = id
    self.name = name
    self.address = address
    self.contactNumber = contactNumber
    self.email = email
  }
  
  init() { }
}
