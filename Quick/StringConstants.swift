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
  
  static let successfulPurchaseTitleString = "Success!"
  static func createSuccessfulPurchaseMessageString(productName: String, purchaseID: String) -> String {
    return "Your purchase of " + productName + " was succesful. Your purchase code is: " + purchaseID
  }
  
  static let purchaseErrorTitleString = "Purchase Error"
  static let purchaseErrorMessageString = "Purchase unavailable at this time, please try again later."
  
  static let unfoundJWTClaim = "Unable to find claim: "
  
  static let error = "Error"
  static let fillInFields = "Please fill in all fields."
  static let invalidCredential = "Ivalid Credentials."
  static let accountTaken = "Email already taken."
  
  /// ViewController Identifiers
  static let homeViewController = "HomeViewController"
  static let authenticateViewController = "AuthenticateViewController"
  static let businessViewController = "BusinessViewController"
  static let productViewController = "ProductViewController"
}
