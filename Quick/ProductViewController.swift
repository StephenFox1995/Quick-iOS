//
//  ProductViewController.swift
//  Quick
//
//  Created by Stephen Fox on 04/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductViewController: QuickViewController {
  
  @IBOutlet private weak var productPrice: UILabel!
  @IBOutlet private weak var productDescription: UILabel!
  @IBOutlet private weak var productName: UILabel!
  var product: Product?
  var business: Business?
  private var network: Network!
  
  var productId: String?
  var shouldFetchProduct: Bool = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.network = Network()
    
    if shouldFetchProduct {
      fetchProductDetails()
    }
    else if let p = self.product { // Only try set, if fetching from network is false.
      self.setProductDetailsUI(p)
    }
  }
  

  private func fetchProductDetails() {
    guard let id = self.productId else { return }
    
    let productEndPoint = Network.NetworkingDetails.createProductEndPoint(id)
    network.requestJSON(productEndPoint) { (success, data) in
      if (success) {
        let json = JSON(data)
        self.product = JSONParser.parseProduct(json)
        self.setProductDetailsUI(self.product)
      } else {
        super.displayMessage(title: StringConstants.networkErrorTitleString,
                           message: StringConstants.networkErrorMessageString)
      }
    }
  }
  
  private func setProductDetailsUI(product: Product?) {
    if let p = product {
      self.productName.text = p.name
      self.productPrice.text = p.price
      self.productDescription.text = p.description
    }
  }
  
  private func purchaseError() {
    self.displayMessage(title: StringConstants.purchaseErrorTitleString ,
                        message: StringConstants.purchaseErrorMessageString)
  }
  
  @IBAction func beginPurchase(sender: AnyObject) {
    // Check product
    guard let p = self.product else { return purchaseError() }
    guard let pID = p.id else { return purchaseError() }
    // Check business
    guard let b = self.business else { return purchaseError() }
    guard let bID = b.id else { return purchaseError() }
    
    let jsonParameters = JSONEncoder.encodePurchase(productID: pID,
                                                    businessID: bID,
                                                    userID: "H1iQEkqB")
    
    let purchaseEndPoint = Network.NetworkingDetails.purchaseEndPoint
    network.postJSON(purchaseEndPoint, jsonParameters: jsonParameters) {
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
  
  
  private func displayPurchaseDetails(purchaseID: String) {
    super.displayQRCodeDetailView(title: StringConstants.successfulPurchaseTitleString,
                                  message: StringConstants.createSuccessfulPurchaseMessageString(self.product!.name!, purchaseID: purchaseID),
                                  qrCodeSeed: purchaseID)
  }
}
