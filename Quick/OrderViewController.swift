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
  
  fileprivate var priceView: PriceView!
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.priceView.updatePrice(price: OrderManager.sharedInstance.getOrder().currentPrice)
  }
  
  private func setupViews() {
    self.priceView = PriceView(price: OrderManager.sharedInstance.getOrder().currentPrice)
    self.view.addSubview(self.priceView)
    
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
    
    constrain(self.view, self.orderTableView, self.orderButton, self.priceView) {
      (superView, orderTableView, orderButton, priceView) in

      
      priceView.top == superView.top
      priceView.trailing == superView.trailing
      priceView.leading == superView.leading
      priceView.width == superView.width
      priceView.height == superView.height * 0.1
      priceView.centerX == superView.centerX
      
      orderButton.bottom == superView.bottom
      orderButton.width == superView.width
      orderButton.leading == superView.leading
      orderButton.height == superView.height * 0.1
      
      orderTableView.leading == superView.leading
      orderTableView.top == priceView.bottom
      orderTableView.width == superView.width
      orderTableView.bottom == orderButton.top
      
    }
  }
  
  
  @objc func order() {
    OrderManager.sharedInstance.beginOrder { (error) in
      if let err = error {
        switch err {
        case .LocationPermissionError:
          super.displayMessage(title: StringConstants.locationPermissionPleaTitle, message: StringConstants.locationPermissionPlea)
        case OrderManager.OrderError.EmptyOrder: // Empty order can be ignore
          return
        case .JSONError:
          super.displayMessage(title: StringConstants.orderErrorTitleString, message: StringConstants.orderErrorMessageString)
        case .NetworkError:
          super.displayMessage(title: StringConstants.networkErrorTitleString, message: StringConstants.networkErrorMessageString)
        }
      }
      else {
        super.displayMessage(title: StringConstants.successfulOrderTitleString, message: StringConstants.successfulOrderMessageString)
      }
    }
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
      return 40
    } else {
      return height
    }
  }
}
