//
//  ProducTableViewDelegate.swift
//  Quick
//
//  Created by Stephen Fox on 29/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductTableViewDataSource: QuickDataSource, UITableViewDataSource {
  
  private var network: Network!
  private weak var tableView: QuickTableView!
  private var products: [Product]?
  private var reuseIdentifier: String!
  
  
  /**
   Initialises a new instance with a reference to the
   tableView this class will be 'datasourcing'
   - paramater tableView: The table to datasource.
   */
  init(tableView: ProductTableView) {
    super.init()
    self.tableView = tableView
    self.tableView.dataSource = self
    
    self.reuseIdentifier = ProductTableView.cellReuseIdentifier
    self.network = Network()
  }
  
  
  override func fetchData(url: String, completetionHandler: (success: Bool) -> Void) {
    self.network.requestJSON(url) { (success, data) in
      if (success) {
        let json = JSON(data)
        self.products = self.createProductArray(json)
        self.tableView.reloadData()
        completetionHandler(success: true)
      } else {
        fxprint("Could not load Products.")
        completetionHandler(success: false)
      }
    }
  }
  
  
  private func createProductArray(json: JSON) -> Array<Product> {
    var productArray = Array<Product>()
    
    for jsonObj in json {
      let product = Product()
      product.id =          jsonObj.1["id"].stringValue
      product.name =        jsonObj.1["name"].stringValue
      product.price =       jsonObj.1["price"].stringValue
      product.description = jsonObj.1["description"].stringValue
      productArray.append(product)
    }
    return productArray
  }
  
  
  override func itemForRowIndex(indexPath: NSIndexPath) -> AnyObject? {
    if let p = self.products {
      return p[indexPath.row]
    } else {
      return nil
    }
  }
  
  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.products != nil {
      return self.products!.count
    } else {
      return 0
    }
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let productCell = tableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier) as! ProductTableViewCell
    let product = self.products![indexPath.row]
    productCell.setTextElements(product)
    return productCell
  }

}
