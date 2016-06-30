//
//  Business.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class Business: QuickBusinessObject {

  
  init(id: String, name: String, address: String, contactNumber: String, email: String) {
    super.init()
    self.id = id
    self.name = name
    self.address = address
    self.contactNumber = contactNumber
    self.email = email
  }
  
  override init() { }
}
