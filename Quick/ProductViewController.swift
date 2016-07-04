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
  
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var productDescription: UILabel!
  @IBOutlet weak var productName: UILabel!
  var product: Product?
  
  var productId: String?
  var shouldFetchProduct: Bool = false
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if shouldFetchProduct {
      fetchProductDetails()
    }
    
    if let p = self.product {
      self.productName.text = p.name
      self.productPrice.text = p.price
      self.productDescription.text = p.description
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
      } else {
        // TODO: Alert user unable to load.
      }
    }
  }
}
