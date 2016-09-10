//
//  ProductPricingStrip.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class ProductPricingStripView: StripView {
  
  private var productNameLabel = UILabel()
  private var product: Product!
  private var purchaseButton = UIButton()
  
  init(product: Product) {
    super.init(frame: CGRectZero)
    self.product = product
    self.setupViews()
  }
  
  private func setupViews() {
    self.productNameLabel.text = self.product.name
    self.addSubview(self.productNameLabel)
    
    
    
    constrain(self, self.productNameLabel) {
      (superView, productNameLabel) in
      productNameLabel.width == superView.width
      productNameLabel.height == superView.height
      productNameLabel.leading == superView.leading
      productNameLabel.top == superView.top
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
