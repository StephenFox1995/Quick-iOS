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
 Class that display info about a Product and allows a user to purchase the Product
 */
class ProductViewController: QuickViewController {
  
  /// Product property, this needs to be set for the view to load product info
  var product: Product!
  var business: Business?
  
  private var productImageView: ProductImageView!
  private var productPricingStripView: ProductPricingStripView!
  private var purchaseButton = QButton()
  private var network = Network()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    self.setupViews()
  }
  
  private func setupViews() {
    
    self.productImageView = ProductImageView()
    self.view.addSubview(self.productImageView)
    dispatch_async(dispatch_get_global_queue(0, 0)) {
      let url = NSURL(string: "http://img.bbystatic.com/BestBuy_US/images/products/4357/4357800_sd.jpg")
      let nsdata = NSData.init(contentsOfURL: url!)
      dispatch_async(dispatch_get_main_queue(), {
        let uiImage = UIImage(data: nsdata!)
        self.productImageView.image = uiImage
      })
    }
    
    self.productPricingStripView = ProductPricingStripView(product: self.product!)
    self.view.addSubview(self.productPricingStripView)
    
    self.purchaseButton.setTitle("PURCHASE", forState: .Normal)
    self.purchaseButton.titleLabel?.setKernAmount(2.0)
    self.purchaseButton.addTarget(self, action: #selector(ProductViewController.beginPurchase), forControlEvents: .TouchUpInside)
    self.purchaseButton.layer.cornerRadius = 0
    self.view.addSubview(self.purchaseButton)
    
    constrain(self.view, self.productImageView, self.productPricingStripView, self.purchaseButton) {
      (superView, productImageView, pricingView, purchaseButton) in
      productImageView.leading == superView.leading
      productImageView.trailing == superView.trailing
      productImageView.height == superView.height * 0.4
      productImageView.top == superView.top
      
      pricingView.width == superView.width
      pricingView.top == productImageView.bottom
      pricingView.height == superView.height * 0.1
      
      purchaseButton.bottom == superView.bottom
      purchaseButton.leading == superView.leading
      purchaseButton.trailing == superView.trailing
      purchaseButton.height == superView.height * 0.1
    }
  }
  
  
  // Attempts to make a purchase.
  @objc private func beginPurchase() {
    let network = Network()
    // Check product
    guard let p = self.product else { return purchaseError() }
    guard let pID = p.id else { return purchaseError() }
    // Check business
    guard let b = self.business else { return purchaseError() }
    guard let bID = b.id else { return purchaseError() }
    
    let jsonParameters = JSONEncoder.jsonifyPurchase(productID: pID, businessID: bID)
    
    let purchaseEndPoint = Network.NetworkingDetails.purchaseEndPoint
    network.postJSONAuthenticated(purchaseEndPoint, jsonParameters: jsonParameters) {
      (success, data) in
      if (success) {
        let json = JSON(data)
        let purchaseID = JSONParser.parsePurchaseID(json)
        self.displayPurchaseDetails(purchaseID)
        
      } else {
        super.displayMessage(title: StringConstants.networkErrorTitleString,
                             message: StringConstants.networkErrorMessageString)
      }
    }
  }
  
  // Purchase error alert.
  private func purchaseError() {
    self.displayMessage(title: StringConstants.purchaseErrorTitleString ,
                        message: StringConstants.purchaseErrorMessageString)
  }
  
  // Display the details of a successful purchase.
  private func displayPurchaseDetails(purchaseID: String) {
    super.displayQRCodeDetailView(title: StringConstants.successfulPurchaseTitleString,
                                  message: StringConstants.createSuccessfulPurchaseMessageString(self.product!.name!, purchaseID: purchaseID),
                                  qrCodeSeed: purchaseID)
  }
}
