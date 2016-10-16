//
//  NetworkingDetails.swift
//  QuickApp
//
//  Created by Stephen Fox on 20/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 Class to store constant values about backend urls.
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
  fileprivate static let businessProductEndPointDev = NetworkingDetails.baseEndPointDev + "/product"
  fileprivate static let businessProductEndPointProduction = "" // TODO: to be decided.
  
  /**
   Creates a string url for business products.*/
  static func createBusinessProductEndPoint(_ businessID: String) -> String {
    let resource = "/?businessID=\(businessID)"
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
  
  
  fileprivate static let orderEndPointDev = NetworkingDetails.baseEndPointDev + "/order"
  fileprivate static let orderEndPointProduction = "" // TODO: to be decided.
  fileprivate static let purchaseEndPointDev = NetworkingDetails.baseEndPointDev + "/purchase"
  fileprivate static let purchaseEndPointProduction = ""
  
  /**
   String url for purchases.
   */
  static var orderEndPoint: String {
    get {
      return AppDelegate.devEnvironment ? orderEndPointDev: orderEndPointProduction
    }
  }
}

