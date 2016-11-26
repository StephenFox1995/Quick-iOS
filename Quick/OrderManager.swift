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
 Class that manages storing objects for ordering.
 */
class OrderManager {
  typealias OrderCompletion = ((_ error: Error?) -> Void)
  
  static let sharedInstance = OrderManager()
  /// The order currently being made by the user.
  /// There can only ever be one order being made within the application at a time.
  fileprivate var order = Order()
  fileprivate init() {}
  fileprivate var location: Location?
  fileprivate var network: Network?
  weak var updates: OrderManagerUpdates?
  
  
  
  enum OrderError: Error {
    case EmptyOrder
  }
  
  func getOrder() -> Order {
    return self.order
  }
  
  func addToOrder(product: Product) {
    self.order.add(product: product)
    self.updates?.orderManager(orderManager: self, newProductForOrder: product)
    self.updates?.orderManager(orderManager: self, newOrderPrice: self.order.currentPrice)
  }
  
  
  func beginOrder(completion: @escaping OrderCompletion) {
    if self.order.products.count <= 0 {
      return completion(OrderError.EmptyOrder)
    }
    
    // Get the user's current location coordinates.
    self.location = self.location ?? Location()
    self.location!.getCurrentLocation { (coordinates, error) in
      if (error != nil) {
        completion(error)
      }
      self.getOrder().location = coordinates // Attach coordinates to order.
      
      self.network = self.network ?? Network()
      do {
        let json = try JSON.OrderEncoder.jsonifyOrder(order: self.order)
        self.network!.postJSON(NetworkingDetails.orderEndPoint, jsonParameters: json) {
          (sucess, response) in
        }
      }
      catch {
        completion(JSON.JSONError.MissingValue)
      }
    }
  }
  
}
