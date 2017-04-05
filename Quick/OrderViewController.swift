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
    let signOut = UIBarButtonItem(title: "Clear Order", style: .plain, target: self, action: #selector(OrderViewController.clearOrder))
        navigationItem.rightBarButtonItems = [signOut]
    self.setupViews()
    
  }
  
  @objc fileprivate func clearOrder() {
    OrderManager.sharedInstance.clearOrder()
    self.priceView.updatePrice(price: 0.0)
    self.orderTableView.reloadData()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let order = OrderManager.sharedInstance.getOrder() {
      self.priceView.updatePrice(price: order.currentPrice)
      self.orderTableView.reloadData()
    }
  }
  
  
  fileprivate func setupViews() {
    if let order = OrderManager.sharedInstance.getOrder() {
      self.priceView = PriceView(price: order.currentPrice)
    } else {
      self.priceView = PriceView(price: 0.00)
    }
    
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
  
  
  fileprivate func askTravelMode(completion: @escaping (TravelMode) -> ()) {
    let travelModeController =
      UIAlertController(title: "Travel Mode", message: "How are you travelling?", preferredStyle: .alert)
    let walkingMode = UIAlertAction(title: "walking", style: .default) {
      (UIAlertAction) in
      completion(.Walking)
    }
    let cyclingMode = UIAlertAction(title: "cycling", style: .default) {
      (UIAlertAction) in
      completion(.Bicycling)
    }
    let drivingMode = UIAlertAction(title: "driving", style: .default) {
      (UIAlertAction) in
      completion(.Driving)
    }
    travelModeController.addAction(walkingMode)
    travelModeController.addAction(cyclingMode)
    travelModeController.addAction(drivingMode)
    self.present(travelModeController, animated: true, completion: nil)
  }
  
  
  @objc func order() {
    self.askTravelMode {
      travelMode in
      if let order = OrderManager.sharedInstance.getOrder() {
        order.travelMode = travelMode
        OrderManager.sharedInstance.beginOrder { (orderId, collectionTime, error) in
          if let err = error {
            switch err {
            case .LocationPermissionError:
              super.displayMessage(title: StringConstants.locationPermissionPleaTitle, message: StringConstants.locationPermissionPlea)
            case OrderManager.OrderError.EmptyOrder: // Empty order can be ignored
              return
            case .JSONError:
              super.displayMessage(title: StringConstants.orderErrorTitleString, message: StringConstants.orderErrorMessageString)
            case .NetworkError:
              super.displayMessage(title: StringConstants.networkErrorTitleString, message: StringConstants.networkErrorMessageString)
            }
          }
          else {
            
            if let id = orderId {
              if let coll = collectionTime {
                if #available(iOS 10.0, *) {
                  let isoFormatter = ISO8601DateFormatter()
                  isoFormatter.formatOptions = .withTimeZone
                  let date = isoFormatter.date(from: coll)
//                  let collectionDateString = dateFormatter.string(from: date!)
                  var message = "Your order number is: \(id)\n"
                  message.append("Please collect at \(coll)")
                  super.displayMessage(title: StringConstants.successfulOrderTitleString, message: message)
                }
              } else {}
              return
            } else {
              super.displayMessage(title: StringConstants.successfulOrderTitleString, message: StringConstants.successfulOrderMessageString)
            }
          }
        }
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

extension Date {
  public static func dateFromISOString(string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
    dateFormatter.timeZone = NSTimeZone.local
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    return dateFormatter.date(from: string)!
  }
}
