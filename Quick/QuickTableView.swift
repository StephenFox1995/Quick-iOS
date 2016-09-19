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

  /**
   Register all Nibs/ classes that are needed to
   display ui elements of the table view.
   */
  func registerNib(_ nibName: String, bundle: Bundle?, reuseIdentifier: String) {
    let cell = UINib(nibName: nibName, bundle: bundle)
    self.register(cell, forCellReuseIdentifier: reuseIdentifier)
  }
  
  
  func registerClass() { }
}
