//
//  ProductOptionsTableViewDataSource.swift
//  QuickApp
//
//  Created by Stephen Fox on 16/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionsTableViewDataSource: QuickDataSource, UITableViewDataSource {
  
  
  fileprivate weak var tableView: ProductOptionsTableView!
  fileprivate var productOptions: [ProductOption]?
  fileprivate var reuseIdentifier: String!
  
  init(tableView: ProductOptionsTableView) {
    super.init()
    self.tableView = tableView
    self.tableView.dataSource = self
    self.reuseIdentifier = ProductOptionsTableView.cellReuseIdentifier
    self.tableView.register(ProductOptionTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
  }
  
  /**
   Set the options for the tableView.
   - parameter productOptions: The options for the product.
   */
  func setProductOptions(productOptions: [ProductOption]) {
    self.productOptions = productOptions
    self.tableView.reloadData()
  }
  
  
  
  override func itemForRowIndex(_ indexPath: IndexPath) -> AnyObject? {
    if let pOptions = self.productOptions {
      if pOptions.indices.contains((indexPath as NSIndexPath).row) {
        return pOptions[(indexPath as NSIndexPath).row]
      }
      return nil
    }
    return nil
  }
  
  // MARK : UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.productOptions != nil {
      return self.productOptions!.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let pOptionCell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as! ProductOptionTableViewCell
    let pOption = self.itemForRowIndex(indexPath) as! ProductOption
    pOptionCell.textLabel?.text = pOption.name
    return pOptionCell
  }
}
