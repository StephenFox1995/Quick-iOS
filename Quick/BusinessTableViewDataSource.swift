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
  
  fileprivate var network: Network!
  fileprivate weak var tableView: QuickTableView!
  fileprivate var businesses: [Business]?
  fileprivate var reuseIdentifier: String!
  
  init(tableView: BusinessTableView) {
    super.init()
    self.tableView = tableView
    self.tableView.dataSource = self
    self.network = Network()
  }
  
  
  
  override func fetchData(_ url: String, completetionHandler: @escaping (_ success: Bool) -> Void) {
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
  
  
  override func itemForRowIndex(_ indexPath: IndexPath) -> AnyObject? {
    if let b = self.businesses {
      if b.indices.contains((indexPath as NSIndexPath).row) {
        return b[(indexPath as NSIndexPath).row]
      }
      return nil
    }
    return nil
  }
  
  
  
  fileprivate func createBusinessArray(_ json: JSON) -> Array<Business> {
    var businessArray = Array<Business>()
    
    for jsonObj in json {
      let business = Business()
      business.id =             jsonObj.1["id"].stringValue
      business.name =           jsonObj.1["name"].stringValue
      business.address =        jsonObj.1["address"].stringValue
      business.contactNumber =  jsonObj.1["contactNumber"].stringValue
      businessArray.append(business)
    }
    return businessArray
  }
  
  
  // MARK: UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.businesses != nil {
      return self.businesses!.count
    } else {
      return 0;
    }
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let businessCell =
      tableView.dequeueReusableCell(withIdentifier: BusinessTableView.cellReuseIdentifier) as! BusinessTableViewCell
    let business = self.businesses![(indexPath as NSIndexPath).row]
    businessCell.setTextElements(business)
    return businessCell
  }

}
