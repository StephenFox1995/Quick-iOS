//
//  ViewController.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
  
  var productTableView: BusinessTableView!
  var productTableViewDataSource: BusinessTableViewDataSource!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupProductTableView()
    
  }
  
  
  // Set up tableview to display products.
  private func setupProductTableView() {
    if self.productTableView == nil {
      self.productTableView = BusinessTableView(frame: CGRectMake(
        0, 0, Screen.width, Screen.height), style: .Plain)
      self.productTableView.delegate = self
      self.productTableViewDataSource = BusinessTableViewDataSource(tableView: self.productTableView)
      
    }
    self.view.addSubview(self.productTableView)
  }
  
  
}

