//
//  OrderNavigationController.swift
//  QuickApp
//
//  Created by Stephen Fox on 05/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class OrderNavigationController: QuickNavigationController,
OrderManagerUpdates {
  
  fileprivate var orderAmountLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    OrderManager.sharedInstance.updates = self
    orderAmountLabel = UILabel(frame: CGRect(x: self.navigationBar.frame.width - 110,
                                             y: 0,
                                             width: 100,
                                             height: self.navigationBar.frame.height))
    self.updateOrderAmountText(amount: 0.0)
    orderAmountLabel.font = UIFont.qFontDemiBold(12)
    self.navigationBar.addSubview(orderAmountLabel)
  }
  
  fileprivate func updateOrderAmountText(amount: Double) {
    let amountString = String.currencyFormat(amount: amount)
    self.orderAmountLabel.text = "ORDER: €" + amountString
  }
}

// MARK: OrderManagerUpdates
extension OrderNavigationController {
  func orderManager(orderManager: OrderManager, newProductForOrder: Product) { }
  
  func orderManager(orderManager: OrderManager, newOrderPrice: Double) {
    self.updateOrderAmountText(amount: newOrderPrice)
  }
}
