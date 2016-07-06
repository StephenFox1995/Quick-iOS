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
  private var network: Network!
  
  var productId: String?
  var shouldFetchProduct: Bool = false
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.network = Network()
    
    if shouldFetchProduct {
      fetchProductDetails()
    }
    else if let p = self.product { // Only try set if fetching from network is false.
      self.setProductDetailsUI(p)
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  private func fetchProductDetails() {
    guard let id = self.productId else {
      return
    }
    
    let productEndPoint = Network.NetworkingDetails.createProductEndPoint(id)
    
    network.requestJSON(productEndPoint) { (success, data) in
      if (success) {
        let json = JSON(data)
        self.product = JSONParser.parseProduct(json)
        self.setProductDetailsUI(self.product)
      } else {
        super.displayError(title: StringConstants.networkErrorTitleString,
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
  
  
  @IBAction func beginPurchase(sender: AnyObject) {
    let jsonParameters = JSONEncoder.encodePurchase(productID: "S1jzmCpr", businessID: "rkIeje2r", userID: "H1iQEkqB")
    let purchaseEndPoint = Network.NetworkingDetails.purchaseEndPoint
    network.postJSON(purchaseEndPoint, jsonParameters: jsonParameters) {
      (success, data) in
      if (success) {
        // TODO: Notify of success.
      } else {
        super.displayError(title: StringConstants.networkErrorTitleString,
                           message: StringConstants.networkErrorMessageString)
      }
    }
  }
}
