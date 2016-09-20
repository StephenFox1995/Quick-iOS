//
//  ProductTableViewController.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 This class presents a list of products.
 */
class ProductsTableViewController: QuickViewController, UITableViewDelegate {
  
  fileprivate var productTableView: ProductTableView!
  fileprivate var productTableViewDataSource: ProductTableViewDataSource!
  var business: Business?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Products"
    self.fillTableView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.hideNavigationBar = true
  }
  
  
  fileprivate func fillTableView() {
    if self.productTableViewDataSource == nil {
      let rect = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
      self.productTableView = ProductTableView(frame: rect, style: .plain)
      self.productTableView.delegate = self
      self.view.addSubview(self.productTableView)
    }
    if self.productTableViewDataSource == nil {
      self.productTableViewDataSource = ProductTableViewDataSource(tableView: self.productTableView)
    }
    guard let business = self.business else {
      fxprint("ProductTableViewController#business property not set.")
      return
    }
    
    guard let businessID = business.id else {
      return
    }
    
    let productsEndPoint = Network.NetworkingDetails.createBusinessProductEndPoint(businessID)
    self.productTableViewDataSource.fetchData(productsEndPoint) { (success) in
      if (!success) {
        super.displayMessage(title: StringConstants.networkErrorTitleString,
                             message: StringConstants.networkErrorMessageString)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension ProductsTableViewController {
  @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let product = self.productTableViewDataSource.itemForRowIndex(indexPath)
    
    guard let p = product as? Product else { return }
    guard let b = self.business else { return }
    
    let productViewController = ProductViewController()
    productViewController.product = p
    productViewController.business = b
    self.navigationController?.pushViewController(productViewController, animated: true);
  }
}
