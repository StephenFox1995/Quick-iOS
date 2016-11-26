//
//  Order.swift
//  QuickApp
//
//  Created by Stephen Fox on 19/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import CoreLocation

/**
 An order can contain products.
 */
class Order: QuickBusinessObject {
  fileprivate(set) var products: [Product] = []
  var location: CLLocationCoordinate2D?
  
  var currentPrice: Double {
    get {
      return products.reduce(0.0) { return $0 + $1.orderPrice }
    }
  }
  
  // MARK: Object Life Cycle
  init(withProducts products: [Product]) {
    super.init()
    self.products = products
  }
  
  init(withProduct product: Product) {
    super.init()
    self.products.append(product)
  }
  
  
  override init() { }
  
  func getProducts() -> [Product] {
    return self.products
  }
  
  func add(product: Product) {
    self.products.append(product)
  }
  
  
  
  /// Checks to see if a product has already been added to the order
  /// by comparing the id of the product.
  func has(product: Product) -> Bool {
    return self.products.contains { return $0.id! == product.id! }
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
