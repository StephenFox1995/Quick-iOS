//
//  BusinessTableViewDataSource.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class BusinessTableViewDataSource: QuickDataSource, UITableViewDataSource {
  
  private var network: Network!
  private weak var tableView: QuickTableView!
  private var businesses: [Business]?
  private var reuseIdentifier: String!
  
  init(tableView: BusinessTableView) {
    super.init()
    self.tableView = tableView
    self.tableView.dataSource = self
    
    self.network = Network()
    self.fetchDataFromNetwork()
  }
  
  
  private func fetchDataFromNetwork() {
    let businessEndPoint = Network.NetworkingDetails.businessEndPoint
    self.network.requestJSON(businessEndPoint) { (success, data) in
      if (success) {
        let json = JSON(data)
        self.businesses = self.createBusinessArray(json)
        self.tableView.reloadData()
      } else {
        print("There was an error retrieving Businesses.")
        // TODO: Alert user unable to load.
      }
    }
  }
  
  
  override func itemForRowIndex(indexPath: NSIndexPath) -> AnyObject? {
    if businesses != nil {
      return businesses![indexPath.row]
    } else {
      return nil
    }
  }
  
  private func createBusinessArray(json: JSON) -> Array<Business> {
    let businessArray = NSMutableArray()
    
    for jsonObj in json {
      let business = Business()
      business.id =             jsonObj.1["id"].stringValue
      business.name =           jsonObj.1["name"].stringValue
      business.address =        jsonObj.1["address"].stringValue
      business.contactNumber =  jsonObj.1["contact_number"].stringValue
      businessArray.addObject(business)
    }
    return businessArray as AnyObject as! [Business]
  }
  
  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.businesses != nil {
      return self.businesses!.count
    } else {
      return 0;
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let businessCell =
      tableView.dequeueReusableCellWithIdentifier(BusinessTableView.cellReuseIdentifier) as! BusinessTableViewCell
    let business = self.businesses![indexPath.row]
    businessCell.setTextElements(business)
    return businessCell
  }

}
