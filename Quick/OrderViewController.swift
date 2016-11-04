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
  fileprivate var orderButton: QButton!
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.orderTableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Current Order"
    self.setupViews()
    
  }
  
  private func setupViews() {
    self.orderTableView = OrderTableView()
    self.orderTableViewDataSource = OrderTableViewDataSource(tableView: self.orderTableView, cellReuseIdentifier: OrderTableView.cellReuseIdentifier)
    self.view.addSubview(self.orderTableView)
    
    self.orderButton = QButton()
    self.orderButton.setTitle("ORDER", for: UIControlState())
    self.orderButton.titleLabel?.setKernAmount(2.0)
//    self.orderButton.addTarget(self, action: #selector(ProductViewController.addProductToOrder), for: .touchUpInside)
    self.orderButton.layer.cornerRadius = 0
    self.view.addSubview(self.orderButton)
    
    constrain(self.view, self.orderTableView, self.orderButton) {
      (superView, orderTableView, orderButton) in
      orderTableView.leading == superView.leading
      orderTableView.top == superView.top
      orderTableView.width == superView.width
      orderTableView.bottom == superView.bottom
      
      orderButton.bottom == superView.bottom
      orderButton.width == superView.width
      orderButton.leading == superView.leading
      orderButton.height == superView.height * 0.1
    }
  }
}
