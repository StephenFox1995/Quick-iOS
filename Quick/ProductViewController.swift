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
  
  fileprivate var productImage: ProductImage!
  fileprivate var productPricingStripView: ProductPricingStripView!
  fileprivate var purchaseButton = QButton()
  fileprivate var network = Network()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.viewControllerBackgroundGray()
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    
    self.productImage = ProductImage()
    self.view.addSubview(self.productImage)
    DispatchQueue.global(priority: 0).async {
      let url = URL(string: "http://blog.stridekick.com/wp-content/uploads/2015/10/starbucks-cup-of-coffee-to-go.png")
      let nsdata = try? Data.init(contentsOf: url!)
      DispatchQueue.main.async(execute: {
        let uiImage = UIImage(data: nsdata!)
        self.productImage.imageView.image = uiImage
      })
    }
    
    self.productPricingStripView = ProductPricingStripView(product: self.product!)
    self.view.addSubview(self.productPricingStripView)
    
    self.purchaseButton.setTitle("PURCHASE", for: UIControlState())
    self.purchaseButton.titleLabel?.setKernAmount(2.0)
    self.purchaseButton.addTarget(self, action: #selector(ProductViewController.beginPurchase), for: .touchUpInside)
    self.purchaseButton.layer.cornerRadius = 0
    self.view.addSubview(self.purchaseButton)
    
    constrain(self.view, self.productImage, self.productPricingStripView, self.purchaseButton) {
      (superView, productImage, pricingView, purchaseButton) in
      productImage.width == superView.width
      productImage.centerX == superView.centerX
      productImage.height == superView.height * 0.4
      productImage.top == superView.top
      
      pricingView.width == superView.width
      pricingView.top == productImage.bottom
      pricingView.height == superView.height * 0.2
      
      purchaseButton.bottom == superView.bottom
      purchaseButton.leading == superView.leading
      purchaseButton.trailing == superView.trailing
      purchaseButton.height == superView.height * 0.1
    }
  }
  
  
  // Attempts to make a purchase.
  @objc fileprivate func beginPurchase() {
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
  fileprivate func purchaseError() {
    self.displayMessage(title: StringConstants.purchaseErrorTitleString ,
                        message: StringConstants.purchaseErrorMessageString)
  }
  
  // Display the details of a successful purchase.
  fileprivate func displayPurchaseDetails(_ purchaseID: String) {
    super.displayQRCodeDetailView(title: StringConstants.successfulPurchaseTitleString,
                                  message: StringConstants.createSuccessfulPurchaseMessageString(self.product!.name!, purchaseID: purchaseID),
                                  qrCodeSeed: purchaseID)
  }
}
