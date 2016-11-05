//
//  ViewController.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class HomeViewController: QuickViewController, UITableViewDelegate {
  
  fileprivate var businessTableView: BusinessTableView!
  fileprivate var businessTableViewDataSource: BusinessTableViewDataSource!
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationItem.setHidesBackButton(true, animated:false);
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupBusinessTableView()
    // This is temporary until proper signout page is made
//    let signOut = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(HomeViewController.signOut))
//    navigationItem.rightBarButtonItems = [signOut]
  }
  
  // Set up tableview to display products.
  fileprivate func setupBusinessTableView() {
    if self.businessTableView == nil {
      self.businessTableView = BusinessTableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
      self.businessTableView.delegate = self
      self.businessTableViewDataSource = BusinessTableViewDataSource(tableView: self.businessTableView)
      self.businessTableViewDataSource.fetchData("", completetionHandler: { (success) in
        if !success {
          super.displayMessage(title: StringConstants.networkErrorTitleString,
            message: StringConstants.networkErrorMessageString)
        }
      })
    }
    self.view.addSubview(self.businessTableView)
//    self.businessTableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
    
    constrain(self.view, self.businessTableView) {
      (superView, businessTableView) in
      businessTableView.width == superView.width
      businessTableView.top == superView.top
      businessTableView.bottom == superView.bottom
      businessTableView.leading == superView.leading
    }
  }
  
  @objc fileprivate func signOut() {
    let sessionManager = SessionManager.sharedInstance
    if sessionManager.removeSession() {
    }
  }
}

/// UITableViewDelegate
extension HomeViewController {
  
  @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let business = self.businessTableViewDataSource.itemForRowIndex(indexPath)
    guard let b = business as? Business else {
      return // Error alert user.
    }
    let businessViewController = BusinessViewController()
    businessViewController.business = b
    self.navigationController?.pushViewController(businessViewController, animated: true);
  }
  
}


