//
//  OrderViewController.swift
//  QuickApp
//
//  Created by Stephen Fox on 04/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class OrderViewController: QuickViewController {
  
  fileprivate var orderTableView: OrderTableView!
  fileprivate var orderTableViewDataSource: OrderTableViewDataSource!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.orderTableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViews()
  }
  
  private func setupViews() {
    self.orderTableView = OrderTableView()
    self.orderTableViewDataSource = OrderTableViewDataSource(tableView: self.orderTableView, cellReuseIdentifier: OrderTableView.cellReuseIdentifier)
    self.view.addSubview(self.orderTableView)
    
    constrain(self.view, self.orderTableView) {
      (superView, orderTableView) in
      orderTableView.leading == superView.leading
      orderTableView.top == superView.top
      orderTableView.width == superView.width
      orderTableView.bottom == superView.bottom
    }
  }
}
