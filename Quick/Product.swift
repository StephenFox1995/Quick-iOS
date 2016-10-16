//
//  Product.swift
//  Quick
//
//  Created by Stephen Fox on 29/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class Product: QuickBusinessObject {
  
  var businessID: String?
  var options: [ProductOption]?
  
  init(id: String, name: String, price: String, description: String, businessID: String) {
    super.init()
    self.id = id
    self.name = name
    self.description = description
    self.businessID = businessID
    self.price = price
  }
  
  override init() {
    super.init()
  }
}
