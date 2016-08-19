//
//  ViewController.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class HomeViewController: QuickViewController, UITableViewDelegate {
  
  var businessTableView: BusinessTableView!
  var businessTableViewDataSource: BusinessTableViewDataSource!
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBar.translucent = true
  }
  
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
      self.businessTableViewDataSource.fetchData("", completetionHandler: {
        (success) in
        if !success {
          super.displayMessage(title: StringConstants.networkErrorTitleString,
            message: StringConstants.networkErrorMessageString)
        }
      })
    }
    self.view.addSubview(self.businessTableView)
  }
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let business = self.businessTableViewDataSource.itemForRowIndex(indexPath)
    
    guard let b = business as? Business else {
        // Error alert user.
      return
    }
    
    let businessViewController =
      UIStoryboard.viewControllerFromStoryboard("BusinessViewController") as! BusinessViewController
    businessViewController.business = b
    self.navigationController?.pushViewController(businessViewController, animated: true);
  }
}


