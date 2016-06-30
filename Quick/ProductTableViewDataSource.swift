//
//  ProducTableViewDelegate.swift
//  Quick
//
//  Created by Stephen Fox on 29/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductTableViewDataSource: NSObject, UITableViewDataSource {
  
  private var network: Network!
  private weak var tableView: UITableView!
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
    fetchDataFromNetwork()
  }
  
  
  func fetchDataFromNetwork() {
    let productsURLString = Network.NetworkingDetails.createBusinessProductURLString("123123412")
    self.network.requestJSON(productsURLString) { (success, data) in
      if (success) {
        let json = JSON(data)
        self.products = self.createProductArray(json)
        self.tableView.reloadData()
      } else {
        // TODO: Alert user unable to load.
      }
    }
  }
  
  
  private func createProductArray(json: JSON) -> Array<Product> {
    let productArray = NSMutableArray()
    
    for jsonObj in json {
      let product = Product()
      product.id =          jsonObj.1["id"].stringValue
      product.name =        jsonObj.1["name"].stringValue
      product.price =       jsonObj.1["price"].stringValue
      product.description = jsonObj.1["description"].stringValue
      productArray.addObject(product)
    }
    return productArray as AnyObject as! [Product]
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
    productCell.setProductDetails(product)
    return productCell
  }

}
