//
//  Product.swift
//  Quick
//
//  Created by Stephen Fox on 29/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class Product {
  
  var id: String?
  var name: String?
  var description: String?
  var businessID: String?
  
  init(id: String, name: String, description: String, businessID: String) {
    self.id = id
    self.name = name
    self.description = description
    self.businessID = businessID
  }
  
  
//  static func initWithJSON(jsonString: AnyObject) -> Product {
//  }
}
