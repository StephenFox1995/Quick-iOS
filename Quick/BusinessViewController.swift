//
//  ProductViewController.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class BusinessViewController: QuickViewController, UITableViewDelegate {
  
  var business: Business?
  private var network: Network!
  @IBOutlet weak var productTableView: ProductTableView!
  private var productTableViewDataSource: ProductTableViewDataSource!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.title = business?.name
    self.network = Network()
    
    self.setupProductTableView()
  }
  

  private func setupProductTableView() {
    if productTableViewDataSource == nil {
      self.productTableViewDataSource = ProductTableViewDataSource(tableView: self.productTableView)
    }
    self.productTableView.delegate = self
    
    guard let business = self.business else {
      return
    }
    
    guard let businessID = business.id else {
      return
    }
    
    let productsEndPoint = Network.NetworkingDetails.createBusinessProductEndPoint(businessID)
    self.productTableViewDataSource.fetchDataFromNetwork(productsEndPoint)
  }
}
