//
//  PriceView.swift
//  QuickApp
//
//  Created by Stephen Fox on 11/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class PriceView: UIView {
  
  fileprivate var price: String = ""
  fileprivate var amountLabel = UILabel()
  fileprivate var priceTextLabel = UILabel()
  
  init(price: Double) {
    super.init(frame: CGRect.zero)
    self.price = String.currencyFormat(amount: price)
    self.setupViews()
  }
  
  /// Updates the price currently shown by the view.
  func updatePrice(price: Double) {
    self.amountLabel.text = String.currencyFormat(amount: price)
  }
  
  fileprivate func setupViews() {
    // PriceTextLabel setup
    self.priceTextLabel.text = "PRICE"
    self.priceTextLabel.textColor = UIColor.quickGray()
    self.priceTextLabel.font = UIFont.qFontBold(10)
    self.priceTextLabel.textAlignment = .center
    self.addSubview(self.priceTextLabel)
    
    // TODO: Figure otu correct currency
    self.amountLabel.text = "€" + self.price
    self.amountLabel.font = UIFont.qFontRegular(25)
    self.amountLabel.textColor = UIColor.quickGray()
    self.amountLabel.textAlignment = .center
    self.addSubview(self.amountLabel)
    
    constrain(self, self.amountLabel, self.priceTextLabel) {
      (superView, amountLabel, priceTextLabel) in

      amountLabel.leading == superView.leading
      amountLabel.bottom == priceTextLabel.top
      amountLabel.width == superView.width
      amountLabel.top == superView.top
      amountLabel.height == superView.height * 0.6
      
      priceTextLabel.trailing == superView.trailing
      priceTextLabel.width == superView.width
      priceTextLabel.bottom == superView.bottom
      priceTextLabel.top == amountLabel.bottom
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
