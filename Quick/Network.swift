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
  
  typealias NetworkPOSTResponse = (_ success: Bool, _ data: AnyObject?) -> Void
  typealias NetworkGETResponse = (_ success: Bool, _ data: AnyObject?) -> Void
  
  
  /**
   Sends a http GET request to a url.
   
   - parameter urlString: The url string of the resource.
   - parameter response: A callback containing a success flag
                         and the JSON.
   */
  func requestJSON(_ urlString: String,
                   response: @escaping NetworkGETResponse) {
    let authHeaders = self.authHeaders()
    Alamofire
      .request(urlString,
               method: .get,
               headers: authHeaders)
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
  func postJSON(_ urlString: String,
                jsonParameters: [String: AnyObject]?,
                response: @escaping NetworkPOSTResponse) {
    let authHeaders = self.authHeaders()
    Alamofire
      .request(urlString,
               method: .post,
               parameters: jsonParameters,
               encoding: JSONEncoding.default,
               headers: authHeaders)
      .validate()
      .responseJSON {
        (afResponse) in
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
  
  
  func authHeaders() -> [String: String]? {
    // Set access token, if available for AccessTokenAdapter.
    if (SessionManager.sharedInstance.activeSessionAvailable()) {
      if let accessToken = SessionManager.sharedInstance.getTokenString() {
        let tokenString = "Bearer " + accessToken
        return ["Authorization": tokenString]
      }
    }
    return nil
  }
}

