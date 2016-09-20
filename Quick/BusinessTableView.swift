//
//  BusinessTableView.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 BusinessTableView is the default classs used to display
 businesses in a table.
 */
class BusinessTableView: QuickTableView {
  
  /**
   The reuse identifier used for table row cells
   */
  static let cellReuseIdentifier = "businessCell"
  
  fileprivate let cellNibName = "BusinessTableViewCell"
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    self.register()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.register()
  }
  
  
  func register() {
    self.registerNib(cellNibName, bundle: nil, reuseIdentifier: BusinessTableView.cellReuseIdentifier)
  }
}
