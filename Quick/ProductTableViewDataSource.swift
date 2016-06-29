//
//  ProducTableViewDelegate.swift
//  Quick
//
//  Created by Stephen Fox on 29/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit


class ProductTableViewDataSource: NSObject, UITableViewDataSource {
  
  var network: Network!
  weak var tableView: UITableView!
  
  
  /**
   Initialises a new instance with a reference to the
   tableView this class will be 'datasourcing'
   - paramater tableView: The table to datasource.
   */
  init(tableView: UITableView) {
    super.init()
    self.network = Network()
    self.tableView = tableView
    self.tableView.dataSource = self
    fetchDataFromNetwork()
  }
  
  
  func fetchDataFromNetwork() {
    let productsURLString = Network.NetworkingDetails.createBusinessProductURLString("123123412")
    self.network.requestJSON(productsURLString) { (success, JSON) in
      if (success) {
        
      } else {
        // TODO: Alert user unable to load.
      }
    }
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
