//
//  ProductOptionPickerView.swift
//  QuickApp
//
//  Created by Stephen Fox on 17/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionValuesTableView: UITableView {
  /**
   The reuse identifier used for table row cells.
   */
  static let cellReuseIdentifier = "productOptionValueCell"
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    self.setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupViews()
  }
  
  fileprivate func setupViews() {
  }
  
  @objc fileprivate func handleDone() {
    
  }
  
}


