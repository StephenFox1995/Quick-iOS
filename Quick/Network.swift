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
  
  /**
   Sends a http GET request to a url.
   
   - parameter urlString: The url string of the resource.
   
   - parameter response: A callback containing a success flag
                         and the JSON.
   */
  func requestJSON(urlString: String, response: (success: Bool, data: AnyObject) -> Void) {
    Alamofire.request(.GET, urlString).validate()
      .responseJSON { afResponse in
        switch afResponse.result {
        case .Success:
          if let value = afResponse.result.value {
            response(success: true, data: value)
          }
        case .Failure:
          response(success: false, data: NSNull())
        }
    }
  }
  
  
  
  /**
   Inner class to store constant values about backend urls.
   */
  class NetworkingDetails {
    
    // Base end point
    private static let baseEndPointDev = "http://192.168.1.78:3000"
    private static let baseEndPointProduction = "" // TODO: to be decided.
    
    /**
     * The base end point for all network requests.
     */
    static var baseURLString: String {
      get {
        if AppDelegate.devEnvironment {
          return baseEndPointDev
        } else {
          return baseEndPointProduction
        }
      }
    }
    
    
    // User end point
    private static let userEndPointDev = "http://192.168.1.78:3000/user/id"
    private static let userEndPointProduction = "" // TODO: to be decided.
    
    /**
     * The base end point for all user requests.
     */
    static var userEndPoint: String {
      get {
        if AppDelegate.devEnvironment {
          return userEndPointDev
        } else {
          return userEndPointProduction
        }
      }
    }
    
    
    // TODO: CHANGE THIS!!
    private static let businessEndPointDev = "http://192.168.1.78:3000/business/all"
    private static let businessEndPointProduction = "" // TODO: to be decided
    
    /**
     The base end point for all businesses
     */
    static var businessEndPoint: String {
      get {
        if AppDelegate.devEnvironment {
          return businessEndPointDev
        } else {
          return businessEndPointProduction
        }
      }
    }
    
    
    // All products for business endpoint
    private static let businessProductEndPointDev = "http://192.168.1.78:3000/business"
    private static let businessProductEndPointProduction = "" // TODO: to be decided.
    
    /**
     Creates a string url for business products.*/
    static func createBusinessProductEndPoint(productID: String) -> String {
      let ending = "/\(productID)/products"
      if AppDelegate.devEnvironment {
        return businessProductEndPointDev + ending
      } else {
        return businessProductEndPointProduction + ending
      }
    }
  }
}
