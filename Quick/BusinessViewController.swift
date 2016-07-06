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
  @IBOutlet weak var businessImageView: UIImageView!
  private var productTableViewDataSource: ProductTableViewDataSource!
  
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = business?.name
    self.network = Network()
    
    dispatch_async(dispatch_get_global_queue(0, 0)) {
      let url = NSURL(string: "https://cdn-starbucks.netdna-ssl.com/uploads/images/_framed/d9N8OfXy-4928-3264.jpg")
      let nsdata = NSData.init(contentsOfURL: url!)
      dispatch_async(dispatch_get_main_queue(), {
        let uiImage = UIImage(data: nsdata!)
        self.businessImageView.image = uiImage
      })
    }
    self.setupProductTableView()
  }
  

  private func setupProductTableView() {
    if productTableViewDataSource == nil {
      self.productTableViewDataSource = ProductTableViewDataSource(tableView: self.productTableView)
    }
    self.productTableView.delegate = self
    
    guard let business = self.business else {
      // Alert
      return
    }
    
    guard let businessID = business.id else {
      // Alert
      return
    }
    
    let productsEndPoint = Network.NetworkingDetails.createBusinessProductEndPoint(businessID)
    self.productTableViewDataSource.fetchData(productsEndPoint) { (success) in
      if !success {
        super.displayMessage(title: StringConstants.networkErrorTitleString,
                           message: StringConstants.networkErrorMessageString)
      }
    }
  }
  
  
  // MARK: UITableViewDelegate
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let product = self.productTableViewDataSource.itemForRowIndex(indexPath)
    
    guard let p = product as? Product else { return }
    guard let b = self.business else { return }
    
    let productViewController =
      UIStoryboard.viewControllerFromStoryboard("ProductViewController") as! ProductViewController
    productViewController.product = p
    productViewController.business = b
    self.navigationController?.pushViewController(productViewController, animated: true);
  }
}
