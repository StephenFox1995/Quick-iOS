//
//  ProductOptionValue.swift
//  QuickApp
//
//  Created by Stephen Fox on 16/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionValue {
  
  var name: String?
  var priceDelta: Float?
  
  init(name: String, priceDelta: Float) {
    self.name = name
    self.priceDelta = priceDelta
  }
  
  init() {}
}
