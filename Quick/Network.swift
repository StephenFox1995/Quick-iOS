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
  
  fileprivate var afSessionManager = Alamofire.SessionManager()
  
  init() {
    // Set access token, if available for AccessTokenAdapter.
    if (SessionManager.sharedInstance.activeSessionAvailable()) {
      if let accessToken = SessionManager.sharedInstance.activeSession!.token?.tokenString {
        self.afSessionManager.adapter = AccessTokenAdapter(accessToken: accessToken)
      }
    }
  }
  
  
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
    
    self.afSessionManager
      .request(urlString,
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
                response: @escaping NetworkPOSTResponse) {
    self.afSessionManager.request(urlString,
                      method: .post,
                      parameters: jsonParameters,
                      encoding: JSONEncoding.default)
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
}

class AccessTokenAdapter: RequestAdapter {
  private let accessToken: String
  
  init(accessToken: String) {
    self.accessToken = accessToken
  }
  
  func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
    var urlRequest = urlRequest
    urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    return urlRequest
  }
}


