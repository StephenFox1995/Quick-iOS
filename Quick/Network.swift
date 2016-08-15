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
          break
        case .Failure:
          response(success: false, data: NSNull())
          break
        }
    }
  }
  
  
  /**
   Sends a http POST request to a url.
   
   - parameter urlString:       The url string of the resource.
   - parameter jsonParameters:  A dictionary representation of the json to be sent
                                as the body of the request.
   - parameter response:        A callback containing the reponse.
   */
  func postJSON(urlString: String,
                jsonParameters: Dictionary<String, AnyObject>,
                response: (success: Bool, data: AnyObject) -> Void) {
    Alamofire.request(.POST, urlString, parameters: jsonParameters, encoding: .JSON).validate()
      .responseJSON { afResponse in
        switch afResponse.result {
        case .Success:
          if let value = afResponse.result.value {
            response(success: true, data: value)
          }
        case .Failure:
          response(success: false, data: NSNull())
          break
        }
    }
  }
  
  
  
  /**
   Inner class to store constant values about backend urls.
   */
  class NetworkingDetails {
    //"http://192.168.1.112"
    private static let baseAddress = "http://192.168.1.78"
    private static let port = "3000"
    
    // Base end point
    private static let baseEndPointDev = NetworkingDetails.baseAddress + ":" + NetworkingDetails.port
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
    
    
    // Create user end point
    private static let createUserEndPointDev = NetworkingDetails.baseEndPointDev + "/user";
    private static let createUserEndPointProduction = "" // TODO: tbd.
    
    /**
     * The base end point for creating users requests.
     */
    static var createUserEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? createUserEndPointDev: createUserEndPointProduction;
      }
    }
    
    // User end point
    private static let userEndPointDev = NetworkingDetails.baseEndPointDev + "/user/id"
    private static let userEndPointProduction = "" // TODO: to be decided.
    
    /**
     * The base end point for all user requests.
     */
    static var userEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? userEndPointDev: userEndPointProduction
      }
    }
    
    
    // TODO: CHANGE THIS!!
    private static let businessEndPointDev = NetworkingDetails.baseEndPointDev + "/business/all"
    private static let businessEndPointProduction = "" // TODO: to be decided
    
    /**
     The base end point for all businesses
     */
    static var businessEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? businessEndPointDev: businessEndPointProduction
      }
    }
    
    
    // All products for business endpoint
    private static let businessProductEndPointDev = NetworkingDetails.baseEndPointDev + "/business"
    private static let businessProductEndPointProduction = "" // TODO: to be decided.
    
    /**
     Creates a string url for business products.*/
    static func createBusinessProductEndPoint(productID: String) -> String {
      let resource = "/\(productID)/products"
      return (AppDelegate.devEnvironment ? businessEndPointDev: businessEndPointProduction) + resource
    }
    
    
    private static let productEndPointDev = NetworkingDetails.baseEndPointDev + "/product"
    private static let productEndPointProduction = "" // TODO: to be decided
    
    /**
     Creates a string url for products with the product id.
     */
    static func createProductEndPoint(productID: String) -> String {
      return (AppDelegate.devEnvironment ? productEndPointDev: productEndPointProduction) + "/\(productID))"
    }
    
    
    private static let purchaseEndPointDev = NetworkingDetails.baseEndPointDev + "/purchase"
    private static let purchaseEndPointProduction = "" // TODO: to be decided.
    
    /**
     String url for purchases.
     */
    static var purchaseEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? purchaseEndPointDev: purchaseEndPointProduction
      }
    }
  }
}
