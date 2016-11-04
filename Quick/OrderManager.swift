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
class OrderManager {
  static let sharedInstance = OrderManager()
  /// The order currently being made by the user.
  /// There can only ever be one order being made within the application at a time.
  fileprivate(set) var order = Order()
  fileprivate init() {}
}
