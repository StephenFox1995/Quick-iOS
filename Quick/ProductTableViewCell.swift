//
//  ProductTableViewCell.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductTableViewCell: QuickTableViewCell {
  
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var productName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func setTextElements(_ businessObject: QuickBusinessObject) {
    self.productName.text = businessObject.name
    self.productPrice.text = businessObject.price
  }
}
