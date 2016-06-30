//
//  ProductTableViewCell.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
  
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var productName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setProductDetails(product: Product) {
    self.productName.text = product.name
    self.productPrice.text = product.price
  }
  
}
