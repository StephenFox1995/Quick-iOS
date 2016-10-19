//
//  ProductOptionValuesTableViewCell.swift
//  QuickApp
//
//  Created by Stephen Fox on 18/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionValuesTableViewCell: QuickTableViewCell {
  
  fileprivate var valueName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.textLabel?.setKernAmount(1.0)
    self.textLabel?.font = UIFont.qFontRegular(17)
    self.textLabel?.textAlignment = .center
    self.textLabel?.textColor = UIColor.black
    self.textLabel?.adjustsFontSizeToFitWidth = true
    self.textLabel?.textAlignment = .center
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  /// Set the name of the option.
  func set(productOptionValue: String) {
    self.textLabel?.text = productOptionValue
  }
}
