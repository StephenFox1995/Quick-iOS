//
//  ProductOptionValue.swift
//  QuickApp
//
//  Created by Stephen Fox on 16/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionValue {
  
  var name: String!
  var priceDelta: Double!
  
  init(name: String, priceDelta: Double) {
    self.name = name
    self.priceDelta = priceDelta
  }
  
  func detailsWithCurrency(currency: String) -> String {
    return self.name + " " + currency + String.currencyFormat(amount: self.priceDelta)
  }
}
