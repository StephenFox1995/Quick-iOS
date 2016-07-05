//
//  JSONEncoder.swift
//  Quick
//
//  Created by Stephen Fox on 05/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class JSONEncoder {
  
  /**
   Encodes the parameters in a appropriate format that 
   can be represented as JSON by the networking api.
   
   - parameter productID:   The id of the product for the purchase.
   - parameter businessID:  The id of the business the product belongs to.
   - parameter userID:      The id of the user requesting the purchase.
   */
  static func encodePurchase(productID productID: String,
                                       businessID: String,
                                       userID: String) -> Dictionary<String, String> {
    return ["productID": productID, "businessID": businessID, "userID": userID]
  }
}
