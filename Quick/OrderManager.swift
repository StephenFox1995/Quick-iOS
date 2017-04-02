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
  typealias OrderCompletion = ((_ id: String?, _ collectionTime: String?, _ error: OrderError?) -> Void)
  
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
  fileprivate var timer: Timer!
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
  
  func clearOrder() {
    self.order?.clear()
  }
  
  /**
   Begins the ordering process with the current order managed by this instance.
   - parameter completion: Completion handler
   */
  func beginOrder(completion: @escaping OrderCompletion) {
    if self.order!.products.count <= 0 {
      return completion(nil, nil, OrderError.EmptyOrder)
    }
    
    // Get the user's current location coordinates.
    self.location = self.location ?? Location()
    self.location!.getCurrentLocation { (coordinates, error) in
      if (error != nil) {
        return completion(nil, nil, OrderError.LocationPermissionError)
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
            let orderID = JSON(response!)["order"]["id"].stringValue
            self.pollForCollectionTime(orderID: orderID, businessID: self.order!.business.id!, callback: {
              (collectionTime) in
              completion(orderID, collectionTime, nil)
              self.timer.invalidate()
            })
          } else {
            completion(nil, nil, OrderError.NetworkError)
          }
        }
      }
      catch {
        completion(nil, nil, OrderError.JSONError)
      }
    }
  }
  
  // Once an order has been made, poll for the collection time.
  func pollForCollectionTime(orderID: String, businessID: String, callback: @escaping (_ collectionTime: String?) -> ()) {
    var tryCount = 0
    let url = NetworkingDetails.createOrderCollectionEndpoint(orderID: orderID, businessID: businessID)
    if #available(iOS 10.0, *) {
       self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (x) in
        tryCount = tryCount + 1
        if (tryCount == 10) {
          return callback(nil)
        }
        self.network?.requestJSON(url, response: { (success, response) in
          if (success) {
            let collectionTime = JSON(response!)["collection"].stringValue
            callback(collectionTime)
          }
        })
      }
    } else {
      // Fallback on earlier versions
    }
  }
  
}
