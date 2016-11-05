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
 Class that manages storing objects for ordering.
 */
class OrderManager {
  static let sharedInstance = OrderManager()
  /// The order currently being made by the user.
  /// There can only ever be one order being made within the application at a time.
  fileprivate(set) var order = Order()
  fileprivate init() {}
  
  
  func beginOrder() {
    if self.order.products.count <= 0 {
      // TODO: Callback saying no order made.
    }
    
    let network = Network()
    
    do {
      let json = try JSON.OrderEncoder.jsonifyOrder(order: self.order)
      network.postJSON(NetworkingDetails.orderEndPoint, jsonParameters: json) { (sucess, response) in }
    }
    catch {
    }
    
    
  }
}
