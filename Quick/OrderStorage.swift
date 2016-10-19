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
  
  fileprivate var products = [Product]()
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
    if self.has(product: product) {
      // Get the reference held by the storage.
      let product = self.get(product: product)!
      
      // Check if the option already exists for the product.
      if let loption = product.getOption(name: option.name) {
        // Loop through all option values and append if they don't exist.
        for value in loption.values {
          if !loption.has(value: value) {
            loption.values.append(value)
          }
        }
      } else {
        product.addOption(option: option)
      }
    } else {
      product.addOption(option: option)
      self.products.append(product)
    }
  }
  
  /// Checks to see if a product has already been added to the order
  /// by comparing the id of the product.
  func has(product: Product) -> Bool {
    return self.products.filter { return $0.id! == product.id! }.count > 0
  }
  
  func get(product: Product) -> Product? {
    let x = self.products.filter{ return $0.id! == product.id! }
    if x.count > 0 {
      return x[0]
    } else {
      return nil
    }
  }
}
