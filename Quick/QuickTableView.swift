//
//  QuickTableView.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 Abstract class for table views.
 */
class QuickTableView: UITableView {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    self.setup()
  }
  
  
  fileprivate func setup() {
    self.clipsToBounds = true
//    self.edgesForExtendedLayout = .none;
//    self.extendedLayoutIncludesOpaqueBars = false;
//    self.automaticallyAdjustsScrollViewInsets = false;
  }
  
  /**
   Register all Nibs/ classes that are needed to
   display ui elements of the table view.
   */
  func registerNib(_ nibName: String, bundle: Bundle?, reuseIdentifier: String) {
    let cell = UINib(nibName: nibName, bundle: bundle)
    self.register(cell, forCellReuseIdentifier: reuseIdentifier)
  }
  
  
  func register(class: AnyClass) {
  }
}
