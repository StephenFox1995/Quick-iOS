//
//  ProductTableView.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 ProductTableView is the default class used to display
 products in a table.
*/
class ProductTableView: QuickTableView {
  
  /**
   The reuse identifier used for table row cells.
   */
  static let cellReuseIdentifier = "productCell"
  
  // NIB name for cells.
  fileprivate let cellNibName = "ProductTableViewCell"
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    self.register()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.register()
  }
  
  
  /**
   Register all classes/ nibs for the UI of the tableview.
   */
  fileprivate func register() {
    self.registerNib(cellNibName, bundle: nil, reuseIdentifier:ProductTableView.cellReuseIdentifier)
  }
}
