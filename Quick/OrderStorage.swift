//
//  OrderStorage.swift
//  QuickApp
//
//  Created by Stephen Fox on 18/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 Class that manages storing objects for ordering.
 */
class OrderStorage {
  static let sharedInstance = OrderStorage()
  /// The order currently being made by the user.
  /// There can only ever be one order being made within the application at a time.
  fileprivate(set) var order = Order()
  fileprivate init() {}
  
  
  
  /**
   Adds a `ProductOption` to a `Product`
   that is stored in the internal storage of this classes
   singleton instance.
   If the product doesn't exist, the product will be added
   to the storage, along with the new options.
   If the product does exist then the options will be added to the
   existing product held by this class.
   
   If the product and options already exists, then the values for the option
   will be appended to the product's option, as long as they values don't already exist.
   
   - parameter option: The option to add to a product.
   - parameter product: The Product to add to the storage along with the options.
   */
  func add(option: ProductOption, forProduct product: Product) {
    if self.order.has(product: product) {
      // Get the reference to product held by the order.
      let product = self.order.get(product: product)!
      
      // Check if the option already exists for the product.
      if let loption = product.getOption(name: option.name) {
        // Loop through all option values and append if they don't exist.
        for value in option.values {
          if !loption.has(value: value) {
            loption.values.append(value)
          }
        }
      } else {
        product.addOption(option: option)
      }
    } else {
      product.addOption(option: option)
      self.order.add(product: product)
    }
  }
}
