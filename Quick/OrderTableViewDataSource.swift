//
//  OrderTableViewDataSource.swift
//  QuickApp
//
//  Created by Stephen Fox on 04/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class OrderTableViewDataSource: QuickDataSource, UITableViewDataSource {
  fileprivate weak var tableView : OrderTableView?
  fileprivate var cellReuseIdentifier: String!
  fileprivate var order: Order?
  
  init(tableView: OrderTableView, cellReuseIdentifier: String) {
    super.init()
    self.tableView = tableView
    self.cellReuseIdentifier = cellReuseIdentifier
    self.tableView?.dataSource = self
    self.tableView?.register(OrderTableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
    self.order = OrderManager.sharedInstance.getOrder()
  }
  
  
  override func itemForRowIndex(_ indexPath: IndexPath) -> AnyObject? {
    if let o = self.order {
      if o.products.indices.contains((indexPath as NSIndexPath).row) {
        return o.products[(indexPath as NSIndexPath).row]
      }
      return nil
    }
    return nil
  }
  
  // MARK: UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let o = self.order {
      return o.products.count
    } else {
      return 0
    }
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let orderCell =
      tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as! OrderTableViewCell
    let product = self.itemForRowIndex(indexPath) as! Product
    orderCell.textLabel?.numberOfLines = 0
    orderCell.textLabel?.lineBreakMode = .byWordWrapping;
    
    var productDetails = product.name! + "\n"
    if let options = product.options {
      for option in options {
        productDetails.append(option.name + "\n")
        for value in option.values {
          productDetails.append(value.name + " €" + String(value.priceDelta) + "\n")
        }
      }
    }
    orderCell.textLabel?.text = productDetails
    return orderCell
  }

}
