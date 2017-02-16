//
//  JSONEncoder.swift
//  Quick
//
//  Created by Stephen Fox on 05/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

extension JSON {
  
  public enum JSONError: Error {
    case MissingValue
  }
  
  struct OrderEncoder {
    static func jsonifyOrder(order: Order) throws -> [String: AnyObject] {
      let totalPrice = order.currentPrice // Get total price of order
      
      guard order.business?.id != nil else { // Make sure there is business id for order.
        throw JSONError.MissingValue
      }
      
      guard order.location != nil else { // Get location of user
        throw JSONError.MissingValue
      }
      
      // JSON for request body.
      var json = [
        "order": [
          "products": [],
          "businessID": order.business!.id!,
          "cost": totalPrice,
          "processing": order.processingTime,
          "coordinates": [
            "lat": order.location!.latitude,
            "lng": order.location!.longitude
          ],
          "travelMode": order.travelMode!.rawValue
        ]
      ]
      
      var productsJSON = [Any]()
      
      if order.products.count <= 0 {
        throw JSONError.MissingValue
      } else {
        for product in order.products {
          try productsJSON.append(ProductEncoder.jsonifyProduct(product: product))
        }
      }
      json["order"]?["products"] = productsJSON
      return json as [String : AnyObject]
    }
  }
  
  struct ProductEncoder {
    static func jsonifyProduct(product: Product) throws -> [String: AnyObject] {
      guard product.id != nil else {
        throw JSONError.MissingValue
      }
      guard product.businessID != nil else {
        throw JSONError.MissingValue
      }
      guard product.name != nil else {
        throw JSONError.MissingValue
      }
      guard product.price != nil else {
        throw JSONError.MissingValue
      }
      guard product.description != nil else {
        throw JSONError.MissingValue
      }
      
      var optionsArray = [AnyObject]()
      
      if let options = product.options {
        for option in options {
          let jsonOption = jsonifyProductOption(option: option)
          optionsArray.append(jsonOption as AnyObject)
        }
      }
      
      let json = [
        "product" : [
          "id": product.id!,
          "businessID": product.businessID!,
          "name": product.name!,
          "price": product.price!,
          "description": product.description!,
          "options": optionsArray
        ]
      ]
      return json as [String : AnyObject]
    }
    
    /**
     Encodes the array of `ProductOptionValue` in the following format:
     { name: "Size",
       values: [
          {
            "name": "small",
            "priceDelta": 0
          },
          {
            "name": "Medium",
            "priceDelta": 1.0
          }
        ]
     }
     */
    static func jsonifyProductOption(option: ProductOption) -> [String: AnyObject] {
      let values = self.jsonifyProductOptionValues(values: option.values)
      return ["name": option.name as AnyObject, "values": values as AnyObject]
    }
    
    /**
     Encodes the array of `ProductOptionValue` in the following format:
    {"values":[
        {
          "name": "small",
          "priceDelta": 0
        },
        {
          "name": "Medium",
          "priceDelta": 1.0
        }
     ]}
     */
    static func jsonifyProductOptionValues(values: [ProductOptionValue]) -> [String: Array<Any>] {
      var localValues = ["values": []]
      for value in values {
        localValues["values"]?.append(["name": value.name, "priceDelta": value.priceDelta])
      }
      return localValues
    }
  }
  
  
  
  
  struct UserEncoder {
    static func encodeUser(_ user: User) -> [String: String] {
      return [
        "firstname": user.firstname!,
        "lastname": user.lastname!,
        "email": user.email!,
        "password": user.password!
      ]
    }
    /**
     {
     "authType": "business",
     "user": {
     "email": "someemail@email.com",
     "password": "password"
     }
     }
     */
    static func jsonifyUserForAuthentication(_ user: User) -> [String: String] {
      return ["email": user.email!, "password": user.password!]
    }
    
    static func jsonifyUserObjectForAuthentication(_ user: [String: String]) -> [String: AnyObject] {
      let authType = "user"
      return ["authType": authType as AnyObject, "user": user as AnyObject]
    }
    
    /**
     Creates a JSON representation of a user.
     If successful the JSON will be constructed as below.
     `{
     "user": {
     "firstname": "John",
     "lastname": "smith",
     "email": "johnsmith@email.com",
     "password": "strong-password"
     }
     }`
     
     - parameter userJSON A JSON representation of a user.
     - returns JSON user object
     
     */
    static func createUserJSONObject(_ userJSON: [String: String]) -> [String: AnyObject] {
      return ["user": userJSON as AnyObject]
    }
  }

}
