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
  
  static func jsonifyPurchase(productID: String,
                                        businessID: String) -> [String: AnyObject]{
    return
      ["purchase":
        [
          "productID": productID,
          "businessID": businessID
        ]
      ]
  }
  
  
  
  
  static func encodeUser(_ user: User) -> [String: String] {
    return ["firstname": user.firstname!,
            "lastname": user.lastname!,
            "email": user.email!,
            "password": user.password!]
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
  static func jsonifyUserForAuthentication(_ user: User) -> [String: String]{
    return ["email": user.email!,
            "password": user.password!]
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
  static func createUserJSONObject(_ userJSON: Dictionary<String, String>) -> [String:[String: String]] {
    return ["user": userJSON];
  }
}
