//
//  Network.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Network {
  
  func requestJSON(urlString: String, response: (success: Bool, JSON: AnyObject) -> Void) {
    Alamofire.request(.GET, urlString).validate()
      .responseJSON { afResponse in
        switch afResponse.result {
        case .Success:
          if let value = afResponse.result.value {
            response(success: true, JSON: value)
          }
        case .Failure:
          response(success: false, JSON: NSNull())
        }
    }
  }
  
  
  
  /**
   Inner class to store constant values about backend urls.
   */
  class NetworkingDetails {
    
    // Base URL
    private static let baseURLStringDev = "http://192.168.1.78:3000"
    private static let baseURLStringProduction = "" // TODO: to be decided.
    
    /**
     * The base URL for all network requests.
     */
    static var baseURLString: String {
      get {
        if AppDelegate.devEnvironment {
          return baseURLStringDev
        } else {
          return baseURLStringProduction
        }
      }
    }
    
    
    // User URL
    private static let userURLStringDev = "http://192.168.1.78:3000/user/id"
    private static let userURLStringProduction = "" // TODO: to be decided.
    
    /**
     * The base URL for all user requests.
     */
    static var userURLString: String {
      get {
        if AppDelegate.devEnvironment {
          return userURLStringDev
        } else {
          return userURLStringProduction
        }
      }
    }
    
    
    // All products for business URL
    private static let businessProductURLStringDev = "http://192.168.1.78:3000/business"
    private static let businessProductURLStringProduction = "" // TODO: to be decided.
    
    /**
     Creates a string url for business products.*/
    static func createBusinessProductURLString(productID: String) -> String {
      let ending = "/\(productID)/products"
      if AppDelegate.devEnvironment {
        return businessProductURLStringDev + ending
      } else {
        return businessProductURLStringProduction + ending
      }
    }
  }
}
