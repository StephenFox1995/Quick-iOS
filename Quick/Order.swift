//
//  Order.swift
//  QuickApp
//
//  Created by Stephen Fox on 19/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import CoreLocation

enum TravelMode: String {
  case Walking = "walking"
  case Bicycling = "bicycling"
  case Driving = "driving"
}
/**
 An order can contain products.
 */
class Order: QuickBusinessObject {
  fileprivate(set) var products: [Product] = []
  var location: CLLocationCoordinate2D?
  var business: Business!
  var travelMode: TravelMode?
  
  enum OrderError: Error {
    case ExistingOrderError // When orders for two businesses try to be made.
  }
  
  
  var currentPrice: Double {
    get {
      return products.reduce(0.0) { return $0 + $1.orderPrice }
    }
  }
  
  var processingTime: Int {
    get {
      return products.reduce(0) { return $0 + $1.processing }
    }
  }
  
  // MARK: Object Life Cycle
  /**
    Constructs a new order.
   - parameter id:  The business. All products added
                    must have this exact businessID of this business.
                    Orders cannot be made for multiple businesses at once.
   - parameter products: The products the to add to the order.
   */
  init(forBusiness business: Business, withProducts products: [Product]) {
    super.init()
    self.business = business
    self.products = products
  }
  
  /**
   Constructs a new order.
   - parameter id:  The business. All products added
                    must have this exact businessID of this business. 
                    Orders cannot be made for multiple businesses at once.
   - parameter product: A product the to add to the order.
   */
  init(forBusiness business: Business, withProduct product: Product) {
    super.init()
    self.business = business
    self.products.append(product)
  }
  
  /**
   Constructs a new order.
   - parameter business: The business for this order.
   */
  init(forBusiness business: Business) {
    super.init()
    self.business = business
  }
  
  func getProducts() -> [Product] {
    return self.products
  }
  
  /**
   Adds a product to the order.
   */
  func add(product: Product) throws {
    guard product.businessID == self.business?.id else {
      throw OrderError.ExistingOrderError
    }
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
