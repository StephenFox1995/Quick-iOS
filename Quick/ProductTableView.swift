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
class ProductTableView: UITableView {
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
