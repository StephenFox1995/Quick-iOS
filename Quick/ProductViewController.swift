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
  
  var productId: String?
  var shouldFetchProduct: Bool = false
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
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
    
    let network = Network()
    let productEndPoint = Network.NetworkingDetails.createProductEndPoint(id)
    
    network.requestJSON(productEndPoint) { (success, data) in
      if (success) {
        let json = JSON(data)
        self.product = JSONParser.parseProduct(json)
        self.setProductDetailsUI(self.product)
      } else {
        // TODO: Alert user unable to load.
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
}
