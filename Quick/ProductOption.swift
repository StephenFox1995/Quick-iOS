//
//  ProductOptions.swift
//  QuickApp
//
//  Created by Stephen Fox on 16/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOption {
  var values: [ProductOptionValue]!
  var name: String!
  
  init(name: String, values: [ProductOptionValue]) {
    self.name = name
    self.values = values
  }
}
