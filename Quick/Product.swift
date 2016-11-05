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
  /// The price of the Product when it has been prepared for ordering.
  /// Assumes all attached `ProductOption` are part of theorder  price.
  fileprivate(set) var orderPrice: Double = 0
  
  init(id: String, name: String, price: String, description: String, businessID: String) {
    super.init()
    self.id = id
    self.name = name
    self.description = description
    self.businessID = businessID
    self.price = price
    self.orderPrice = Double(price)! // Order price is the base price initialy.
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
      let o = options.filter { return $0.name == name }
      if o.count > 0 {
        return o[0]
      }
    }
    return nil
  }
  
  /// Updates the current order price with the new option.
  func updateOrderPrice(option: ProductOption) {
    // Go through all the options and update the order price.
    for value in option.values {
      self.orderPrice = self.orderPrice + value.priceDelta
    }
  }
  
  /// Updates the current order price with an array of options
  func updateOrderPrice(options: [ProductOption]) {
    for option in options {
      self.updateOrderPrice(option: option)
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
