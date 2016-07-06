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
    return "Your purchase of " + productName + " was succesful. Your pruchase number is: " + purchaseID
  }
}
