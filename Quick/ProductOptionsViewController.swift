//
//  ProductOptionsViewController.swift
//  QuickApp
//
//  Created by Stephen Fox on 16/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionsViewController: QuickViewController, UITableViewDelegate {
  
  var product: Product!
  fileprivate var productOptionsTableView: ProductOptionsTableView!
  fileprivate var productOptionsDataSource: ProductOptionsTableViewDataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fillTableView()
  }
  
  
  
  fileprivate func fillTableView() {
    if self.productOptionsDataSource == nil {
      // Setup tableview.
      let rect = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
      self.productOptionsTableView = ProductOptionsTableView(frame: rect, style: .plain)
      self.productOptionsTableView.delegate = self
      
      // Set datasource.
      self.productOptionsDataSource = ProductOptionsTableViewDataSource(tableView: self.productOptionsTableView)
      self.productOptionsDataSource.setProductOptions(productOptions: self.product.options!)
      self.view.addSubview(self.productOptionsTableView)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}
