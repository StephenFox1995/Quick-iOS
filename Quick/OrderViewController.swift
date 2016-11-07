//
//  OrderViewController.swift
//  QuickApp
//
//  Created by Stephen Fox on 04/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class OrderViewController: QuickViewController, UITableViewDelegate {
  
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
    self.orderTableView.delegate = self
    self.view.addSubview(self.orderTableView)
    
    self.orderButton = QButton()
    self.orderButton.setTitle("ORDER", for: UIControlState())
    self.orderButton.titleLabel?.setKernAmount(2.0)
    self.orderButton.addTarget(self, action: #selector(OrderViewController.order), for: .touchUpInside)
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
  
  
  @objc func order() {
    OrderManager.sharedInstance.beginOrder()
  }
}


extension OrderViewController {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // Get the product to show for this row.
    // Calculate the height based on the amount of product option values.
    let product = self.orderTableViewDataSource.itemForRowIndex(indexPath) as! Product
    
    var optionsAmount: CGFloat = 0
    var valuesAmount: CGFloat = 0
    if let options = product.options {
      optionsAmount = CGFloat(options.count)
      for option in options {
        valuesAmount = valuesAmount + CGFloat(option.values.count)
      }
    }
    
    let height = (optionsAmount + valuesAmount) * 30
    if height == 0 {
      return 20
    } else {
      return height
    }
  }
}
