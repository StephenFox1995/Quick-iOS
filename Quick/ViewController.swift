//
//  ViewController.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
  
  var businessTableView: BusinessTableView!
  var businessTableViewDataSource: BusinessTableViewDataSource!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBusinessTableView()
  }
  
  
  // Set up tableview to display products.
  private func setupBusinessTableView() {
    if self.businessTableView == nil {
      self.businessTableView = BusinessTableView(frame: CGRectMake(
        0, 0, Screen.width, Screen.height), style: .Plain)
      self.businessTableView.delegate = self
      self.businessTableViewDataSource = BusinessTableViewDataSource(tableView: self.businessTableView)
    }
    self.view.addSubview(self.businessTableView)
  }
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let business = self.businessTableViewDataSource.itemForRowIndex(indexPath)
    if let b = business as? Business {
      print(b)
    }
    let productViewController = ProductViewController()
    self.navigationController?.presentViewController(productViewController,
                                                     animated: true, completion: {
    })
  }
  
}

