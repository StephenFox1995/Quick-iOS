//
//  OrderStorage.swift
//  QuickApp
//
//  Created by Stephen Fox on 18/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

/**
 Protocol for recieving updates from the order manager.
 */
protocol OrderManagerUpdates: NSObjectProtocol {
  func orderManager(orderManager: OrderManager, newProductForOrder: Product)
  func orderManager(orderManager: OrderManager, newOrderPrice: Double)
}

/**
 Class that manages ordering.
 */
class OrderManager {
  /// Closure for order completion handling
  typealias OrderCompletion = ((_ error: OrderError?) -> Void)
  
  enum OrderError: Error {
    case LocationPermissionError
    case JSONError
    case NetworkError
    case EmptyOrder
  }
  
  static let sharedInstance = OrderManager()
  /// The order currently being made by the user.
  /// There can only ever be one order being made within the application at a time.
  fileprivate var order: Order?
  fileprivate var location: Location?
  fileprivate var network: Network?
  weak var updates: OrderManagerUpdates?
  
  
  fileprivate init() {}

  /**
   Creates a new order and removes the previous order.
   - parameter business: The business for the order.
   */
  func newOrder(withBusiness business: Business) {
    self.order = Order(forBusiness: business)
  }
  
  func getOrder() -> Order? {
    return self.order
  }
  
  func addToOrder(product: Product) throws {
    try self.order!.add(product: product)
    self.updates?.orderManager(orderManager: self, newProductForOrder: product)
    self.updates?.orderManager(orderManager: self, newOrderPrice: self.order!.currentPrice)
  }
  
  /**
   Begins the ordering process with the current order managed by this instance.
   - parameter completion: Completion handler
   */
  func beginOrder(completion: @escaping OrderCompletion) {
    if self.order!.products.count <= 0 {
      return completion(OrderError.EmptyOrder)
    }
    
    // Get the user's current location coordinates.
    self.location = self.location ?? Location()
    self.location!.getCurrentLocation { (coordinates, error) in
      if (error != nil) {
        return completion(OrderError.LocationPermissionError)
      }
      self.getOrder()!.location = coordinates // Attach coordinates to order.
      
      
      self.network = self.network ?? Network()
      do {
        // Jsonify the order before sending to server.
        let json = try JSON.OrderEncoder.jsonifyOrder(order: self.order!)
        // Send order json to server.
        self.network!.postJSON(NetworkingDetails.orderEndPoint, jsonParameters: json) {
          (sucess, response) in
          if (sucess) {
            completion(nil)
          } else {
            completion(OrderError.NetworkError)
          }
        }
      }
      catch {
        completion(OrderError.JSONError)
      }
    }
  }
  
}
