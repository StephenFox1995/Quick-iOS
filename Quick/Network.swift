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
  func requestJSON(_ urlString: String,
                   response: @escaping (_ success: Bool, _ data: AnyObject?) -> Void) {
    Alamofire.request(urlString,
                      method: .get)
      .validate()
      .responseJSON { afResponse in
      switch afResponse.result {
      case .success:
        if let value = afResponse.result.value {
          response(true, value as AnyObject)
        }
        break
      case .failure:
        response(false, nil)
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
                response: @escaping (_ success: Bool, _ data: AnyObject?) -> Void) {
    Alamofire.request(urlString,
                      method: .post,
                      parameters: jsonParameters)
      .validate()
      .responseJSON {
        (afResponse) in
      switch afResponse.result {
      case .success:
        if let value = afResponse.result.value {
            response(true, value as AnyObject)
        }
      case .failure:
        response(false, nil)
        break
      }
    }
  }
    
  
  func postJSONAuthenticated(_ urlString: String,
                             jsonParameters: [String: AnyObject],
                             response:@escaping (_ success: Bool, _ data: AnyObject?) -> Void) {
    let headers = self.httpHeaders()
    Alamofire.request(urlString,
                      method: .post,
                      parameters: jsonParameters,
                      headers: headers)
      .validate()
      .responseJSON { (afResponse) in
        switch afResponse.result {
        case .success:
          if let value = afResponse.result.value {
            response(true, value as AnyObject)
          }
        case .failure:
          response(false, nil)
          break
        }
    }
  }
  
  private func httpHeaders() -> [String: String] {
    if let sessionToken = SessionManager.sharedInstance.activeSession!.token?.tokenString {
      return [
        "Authorization": "Bearer \(sessionToken)",
        "Content-Type": "application/json"
      ]
    } else {
      return [
        "Content-Type": "application/json"
      ]
    }
  }
  
  

  /**
   Inner class to store constant values about backend urls.
   */
  class NetworkingDetails {
    
    //"http://192.168.1.112"
    fileprivate static let baseAddress = "http://192.168.1.78"
    fileprivate static let port = "3000"
    
    // Base end point
    fileprivate static let baseEndPointDev = NetworkingDetails.baseAddress + ":" + NetworkingDetails.port
    fileprivate static let baseEndPointProduction = "" // TODO: to be decided.
    
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
    fileprivate static let createUserEndPointDev = NetworkingDetails.baseEndPointDev + "/user"
    fileprivate static let createUserEndPointProduction = "" // TODO: tbd.
    
    /**
     * The base end point for creating users requests.
     */
    static var createUserEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? createUserEndPointDev: createUserEndPointProduction;
      }
    }
    
    
    // Authenticate EndPoint
    fileprivate static let authenticateEndPointDev = NetworkingDetails.baseEndPointDev + "/authenticate"
    fileprivate static let authenticateEndPointProduction = "" // TODO: tbd.
    
    /**
     The base end point for autheticating.
     */
    static var authenticateEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? authenticateEndPointDev: authenticateEndPointProduction
      }
    }
    
    // User end point
    fileprivate static let userEndPointDev = NetworkingDetails.baseEndPointDev + "/user/id"
    fileprivate static let userEndPointProduction = "" // TODO: to be decided.
    
    /**
     * The base end point for all user requests.
     */
    static var userEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? userEndPointDev: userEndPointProduction
      }
    }
    
    
    fileprivate static let businessEndPointDev = NetworkingDetails.baseEndPointDev + "/business/all"
    fileprivate static let businessEndPointProduction = "" // TODO: to be decided
    
    /**
     The base end point for all businesses
     */
    static var businessEndPoint: String {
      get {
        return AppDelegate.devEnvironment ? businessEndPointDev: businessEndPointProduction
      }
    }
    
    
    // All products for business endpoint
    fileprivate static let businessProductEndPointDev = NetworkingDetails.baseEndPointDev + "/business"
    fileprivate static let businessProductEndPointProduction = "" // TODO: to be decided.
    
    /**
     Creates a string url for business products.*/
    static func createBusinessProductEndPoint(_ productID: String) -> String {
      let resource = "/\(productID)/products"
      return (AppDelegate.devEnvironment ? businessProductEndPointDev: businessProductEndPointProduction) + resource
    }
    
    
    fileprivate static let productEndPointDev = NetworkingDetails.baseEndPointDev + "/product"
    fileprivate static let productEndPointProduction = "" // TODO: to be decided
    
    /**
     Creates a string url for products with the product id.
     */
    static func createProductEndPoint(_ productID: String) -> String {
      return (AppDelegate.devEnvironment ? productEndPointDev: productEndPointProduction) + "/\(productID))"
    }
    
    
    fileprivate static let purchaseEndPointDev = NetworkingDetails.baseEndPointDev + "/purchase"
    fileprivate static let purchaseEndPointProduction = "" // TODO: to be decided.
    
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


