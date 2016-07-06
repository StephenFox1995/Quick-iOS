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
  }
  
  
  
  override func fetchData(url: String, completetionHandler: (success: Bool) -> Void) {
    let businessEndPoint = Network.NetworkingDetails.businessEndPoint
    self.network.requestJSON(businessEndPoint) { (success, data) in
      if (success) {
        let json = JSON(data)
        self.businesses = self.createBusinessArray(json)
        self.tableView.reloadData()
        completetionHandler(success: true)
      } else {
        fxprint("There was an error retrieving Businesses.")
        completetionHandler(success: false)
      }
    }
  }
  
  
  override func itemForRowIndex(indexPath: NSIndexPath) -> AnyObject? {
    if let b = self.businesses {
      if b.indices.contains(indexPath.row) {
        return b[indexPath.row]
      }
      return nil
    }
    return nil
  }
  
  
  
  private func createBusinessArray(json: JSON) -> Array<Business> {
    var businessArray = Array<Business>()
    
    for jsonObj in json {
      let business = Business()
      business.id =             jsonObj.1["id"].stringValue
      business.name =           jsonObj.1["name"].stringValue
      business.address =        jsonObj.1["address"].stringValue
      business.contactNumber =  jsonObj.1["contact_number"].stringValue
      businessArray.append(business)
    }
    return businessArray
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
