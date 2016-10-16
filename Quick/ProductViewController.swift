//
//  PViewController.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography
import SwiftyJSON

/**
 Class that display info about a Product and allows a user to order the Product
 */
class ProductViewController: QuickViewController {
  
  /// Product property, this needs to be set for the view to load product info
  var product: Product!
  var business: Business?
  
  fileprivate var productImage: ProductImage!
  fileprivate var productPricingStripView: ProductPricingStripView!
  fileprivate var orderButton = QButton()
  fileprivate var network = Network()
  fileprivate var productOptionsStripView: StripView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.viewControllerBackgroundGray()
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    
    self.productImage = ProductImage()
    self.view.addSubview(self.productImage)
    DispatchQueue.global().async {
      let url = URL(string: "http://blog.stridekick.com/wp-content/uploads/2015/10/starbucks-cup-of-coffee-to-go.png")
      let nsdata = try? Data.init(contentsOf: url!)
      DispatchQueue.main.async(execute: {
        let uiImage = UIImage(data: nsdata!)
        self.productImage.imageView.image = uiImage
      })
    }
    
    
    self.productPricingStripView = ProductPricingStripView(product: self.product!)
    self.view.addSubview(self.productPricingStripView)
    
    let optionsButton = QButton()
    optionsButton.setTitle("OPTIONS", for: UIControlState())
    optionsButton.titleLabel?.setKernAmount(2.0)
    optionsButton.backgroundColor = UIColor.quickGray()
    optionsButton.addTarget(self, action: #selector(ProductViewController.seeProductOptions), for: .touchUpInside)
    optionsButton.layer.cornerRadius = 0
    self.productOptionsStripView = StripView(withButton: optionsButton)
    self.view.addSubview(self.productOptionsStripView)
    
    
    self.orderButton.setTitle("ORDER", for: UIControlState())
    self.orderButton.titleLabel?.setKernAmount(2.0)
    self.orderButton.addTarget(self, action: #selector(ProductViewController.beginOrder), for: .touchUpInside)
    self.orderButton.layer.cornerRadius = 0
    self.view.addSubview(self.orderButton)
    
    constrain(self.view, self.productImage, self.productPricingStripView, self.productOptionsStripView, self.orderButton) {
      (superView, productImage, pricingView, optionsStripView, orderButton) in
      productImage.width == superView.width
      productImage.centerX == superView.centerX
      productImage.height == superView.height * 0.2
      productImage.top == superView.top
      
      pricingView.width == superView.width
      pricingView.top == productImage.bottom
      pricingView.height == superView.height * 0.2
      
      optionsStripView.width == superView.width
      optionsStripView.top == pricingView.bottom + 20
      optionsStripView.height == superView.height * 0.1
      
      orderButton.bottom == superView.bottom
      orderButton.leading == superView.leading
      orderButton.trailing == superView.trailing
      orderButton.height == superView.height * 0.1
    }
  }
  
  // Show all the options available for this product, if there are any.
  @objc fileprivate func seeProductOptions() {
    if self.product.options != nil &&
      self.product.options!.count > 0 {
      let productOptionsViewController = ProductOptionsViewController()
      productOptionsViewController.product = self.product
      self.navigationController?.pushViewController(productOptionsViewController, animated: true)
    }
  }
  
  
  // Attempts to make a order.
  @objc fileprivate func beginOrder() {
    let network = Network()
    // Check product
    guard let p = self.product else { return orderError() }
    guard let pID = p.id else { return orderError() }
    // Check business
    guard let b = self.business else { return orderError() }
    guard let bID = b.id else { return orderError() }
    
    let jsonParameters = JSONEncoder.jsonifyOrder(productID: pID,
                                                  businessID: bID) as [String: AnyObject]
    
    let orderEndPoint = NetworkingDetails.orderEndPoint
    network.postJSON(orderEndPoint, jsonParameters: jsonParameters) {
      (success, data) in
      if (success) {
        let json = JSON(data)
        let orderID = JSONParser.parseOrderID(json)
        self.displayOrderDetails(orderID)
      } else {
        super.displayMessage(title: StringConstants.networkErrorTitleString,
                             message: StringConstants.networkErrorMessageString)
      }
    }
  }
  
  // Order error alert.
  fileprivate func orderError() {
    self.displayMessage(title: StringConstants.orderErrorTitleString,
                        message: StringConstants.orderErrorMessageString)
  }
  
  // Display the details of a successful order.
  fileprivate func displayOrderDetails(_ orderID: String) {
    super.displayQRCodeDetailView(title: StringConstants.successfulOrderTitleString,
                                  message: StringConstants.createSuccessfulOrderMessageString(self.product!.name!, orderID: orderID),
                                  qrCodeSeed: orderID)
  }
}
