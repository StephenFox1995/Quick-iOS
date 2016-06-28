//
//  Network.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Alamofire


class Network {
  
  func request(urlString: String) {
    Alamofire.request(.GET, urlString, parameters: ["foo": "bar"])
      .responseJSON { response in
        print(response.request)  // original URL request
        print(response.response) // URL response
        print(response.data)     // server data
        print(response.result)   // result of response serialization
        if let JSON = response.result.value {
          print("JSON: \(JSON)")
        }
    }
  }
  
  
  
  /**
   Inner class to store constant values about backed urls.
   */
  class NetworkingDetails {
    private static let baseURLStringDev = "http://192.168.1.78"
    private static let baseURLStringProduction = "" // tbd
    
    static var baseURLString: String {
      get{
        if (AppDelegate.devEnvironment) {
          return baseURLStringDev
        } else {
          return baseURLStringProduction
        }
      }
    }
    
  }
}
