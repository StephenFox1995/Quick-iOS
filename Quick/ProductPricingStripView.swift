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

  fileprivate var product: Product!
  fileprivate var productNameLabel = UILabel()
  var productPriceView: PriceView!
  
  init(product: Product) {
    super.init(frame: CGRect.zero)
    self.product = product
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    self.productNameLabel.text = self.product.name
    self.productNameLabel.font = UIFont.qFontDemiBold(20)
    self.productNameLabel.textColor = UIColor.quickGray()
    self.productNameLabel.textAlignment = .center
    self.addSubview(self.productNameLabel)
    
    // TODO: Fix this, if the price is actually nil
    if let price = self.product.price {
      self.productPriceView = PriceView(price: price)
      self.addSubview(self.productPriceView)
    }
    
    
    constrain(self, self.productNameLabel, self.productPriceView) {
      (superView, productNameLabel, productPriceView) in
      productNameLabel.width == superView.width
      productNameLabel.height == superView.height * 0.5
      productNameLabel.leading == superView.leading
      productNameLabel.top == superView.top
      
      productPriceView.centerX == superView.centerX
      productPriceView.width == superView.width * 0.3
      productPriceView.top == productNameLabel.bottom
      productPriceView.bottom == superView.bottom
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
