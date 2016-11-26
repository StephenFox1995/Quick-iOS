//
//  StringsConstants.swift
//  Quick
//
//  Created by Stephen Fox on 06/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class StringConstants: NSObject {
  static let networkErrorTitleString = "Network Error"
  static let networkErrorMessageString = "A network error occurred, please try again."
  
  static let successfulOrderTitleString = "Success!"
  static func createSuccessfulOrderMessageString(_ productName: String, orderID: String) -> String {
    return "Your order of " + productName + " was succesful. Your order code is: " + orderID
  }
  
  static let orderErrorTitleString = "Order Error"
  static let orderErrorMessageString = "Order unavailable at this time, please try again later."
  
  static let orderAddedTitleString = "Added"
  static let orderAddedMessageString = "Order has been added, view 'Order' tab to see current orders."
  
  static let unfoundJWTClaim = "Unable to find claim: "
  
  static let error = "Error"
  static let fillInFields = "Please fill in all fields."
  static let invalidCredential = "Ivalid Credentials."
  static let accountTaken = "Email already taken."
  
  
  static let locationPermissionsError = "Cannot access location because of permissions."
  /// ViewController Identifiers
  static let homeViewController = "HomeViewController"
  static let authenticateViewController = "AuthenticateViewController"
  static let businessViewController = "BusinessViewController"
  static let productViewController = "ProductViewController"
}
