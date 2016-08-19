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
    return ["productID": productID,
            "businessID": businessID,
            "userID": userID]
  }
  
  
  
  static func encodeUser(user: User) -> [String: String] {
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
  static func jsonifyUserForAuthentication(user: User) -> [String: String]{
    return ["email": user.email!,
            "password": user.password!]
  }
  
  
  static func jsonifyUserObjectForAuthentication(user: [String: String]) -> [String: AnyObject] {
    let authType = "user"
    return ["authType": authType, "user": user]
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
  static func createUserJSONObject(userJSON: Dictionary<String, String>) -> [String:[String: String]] {
    return ["user": userJSON];
  }
}
