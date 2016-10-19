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
  
  /** Get a product option from the collection of options
      stored with the product.
   - parameter: name The name of the ProductOpion.
   */
  func getOption(name: String) -> ProductOption? {
    if let options = self.options {
      return options.filter{ $0.name == name }[0]
    }
    return nil
  }

  
  
  /// Adds an option to the products array of options.
  func addOption(option: ProductOption) {
    if self.options != nil {
      self.options!.append(option)
    }
    else {
      self.options = [ProductOption]()
      self.options!.append(option)
    }
  }
  
  /**
   Returns a copy of the instance without the options set.
   */
  func copyWithoutOptions() -> Product {
    return Product(id: self.id!,
                   name: self.name!,
                   price: self.price!,
                   description: self.description!,
                   businessID: self.businessID!)
    
  }
  
  
}
