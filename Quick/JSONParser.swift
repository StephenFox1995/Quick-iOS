//
//  JSONParser.swift
//  Quick
//
//  Created by Stephen Fox on 04/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class JSONParser {
  
  static func parseProduct(json: JSON) -> Product {
    let product = Product()
    product.id =          json[0]["id"].stringValue
    product.name =        json[0]["name"].stringValue
    product.price =       json[0]["price"].stringValue
    product.description = json[0]["description"].stringValue
    product.businessID =  json[0]["business_id"].stringValue
    return product
  }
}
