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
  
  enum JSONParserError: Error {
    case unfoundAttribute
  }
  
  /**
   Parses JSON content from server side response.
   
   - parameter json: The json to parse.
   */
  static func parseProduct(_ json: JSON) -> Product {
    let product = Product()
    if let pJSON = json.dictionary {
      product.id =          pJSON["id"]?.stringValue
      product.name =        pJSON["name"]?.stringValue
      product.price =       pJSON["price"]?.stringValue
      product.description = pJSON["description"]?.stringValue
      product.businessID =  pJSON["business_id"]?.stringValue
    }
    return product
  }
  
  static func parseProducts(_ json: JSON) -> [Product] {
    var productArray = [Product]()
    if let products = json["products"].array {
      for productJSON in products {
        let product = Product()
        product.id =          productJSON["id"].stringValue
        product.name =        productJSON["name"].stringValue
        product.price =       productJSON["price"].stringValue
        product.description = productJSON["description"].stringValue
        product.options = JSONParser.parseProductOptions(json: productJSON)
        productArray.append(product)
      }
    }
    return productArray
  }
  
  
  static func parseProductOptions(json: JSON) -> [ProductOption]? {
    var productOptions = [ProductOption]()
    if let options = json["options"].array {
      for option in options {
        let productOption = ProductOption()
        productOption.name = option["name"].stringValue
        productOption.values = JSONParser.parseProductOptionValues(json: option)
        productOptions.append(productOption)
      }
    }
    return productOptions
  }
  
  
  static func parseProductOptionValues(json: JSON) -> [ProductOptionValue] {
    var productOptionValues = [ProductOptionValue]()
    if let values = json["values"].array {
      for value in values {
        let productOptionValue = ProductOptionValue()
        productOptionValue.priceDelta = value["priceDelta"].floatValue
        productOptionValue.name = value["name"].stringValue
        productOptionValues.append(productOptionValue)
      }
    }
    return productOptionValues
  }
  
  
  
  static func parseBusiness(_ json: JSON) -> Business {
    let business = Business()
    if let bJSON = json.dictionary {
      business.id =             bJSON["id"]?.stringValue
      business.name =           bJSON["name"]?.stringValue
      business.address =        bJSON["address"]?.stringValue
      business.contactNumber =  bJSON["contact_number"]?.stringValue
    }
    return business
  }
  
  
  static func parseOrderID(_ json: JSON) -> String {
    return json["order"]["id"].stringValue
  }
  
  
  /**
   Parses a JSON object from a sign up response received from the server.
   - parameter json: The JSON recieved from the server.
   - returns: A `NetworkResponse.UserSignUpResponse` object upon successful parsing of JSON.
   - throws: Throws `JSONParserError.UnfoundAttribute` when a JSON attribute cannot be found.
   */
  static func userSignUpReponse(_ json: JSON) throws -> NetworkResponse.UserSignUpResponse {
    var userSignUpResponse = NetworkResponse.UserSignUpResponse()
    if let responseJSON = json.dictionary {
      userSignUpResponse.expires          = responseJSON["expires"]?.stringValue
      userSignUpResponse.responseMessage  = responseJSON["responseMessage"]?.stringValue
      userSignUpResponse.success          = responseJSON["success"]?.boolValue
      userSignUpResponse.token            = responseJSON["token"]?.stringValue
    }
    // Make sure object is valid.
    guard userSignUpResponse.isValid() else {
      throw JSONParserError.unfoundAttribute
    }
    return userSignUpResponse
  }
  
  static func userAuthenticate(_ json: JSON) throws -> NetworkResponse.UserAuthenticateResponse {
    var userAuthResponse = NetworkResponse.UserAuthenticateResponse()
    if let responseJSON = json.dictionary {
      userAuthResponse.expires          = responseJSON["expires"]?.stringValue
      userAuthResponse.responseMessage  = responseJSON["responseMessage"]?.stringValue
      userAuthResponse.success          = responseJSON["success"]?.boolValue
      userAuthResponse.token            = responseJSON["token"]?.stringValue
    }
    // Make sure object is valid
    guard userAuthResponse.isValid() else {
      throw JSONParserError.unfoundAttribute
    }
    return userAuthResponse
  }
}
