//
//  NetworkResponse.swift
//  Quick
//
//  Created by Stephen Fox on 16/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol NetworkReponseProtocol {
  /** 
   Call to see if the response type is valid.
   This would typically involve the reponse type
   checking that specific fields are not nil, however,
   this can vary.
   */
  func isValid() -> Bool
}

class NetworkResponse {
  
  /// Closure type for a sign up response
  typealias SignUpCompletion = (success: Bool, signUpResponse: UserSignUpResponse?) -> Void
  /**
   Handles a response from sign up.
   Attempts to parse the user details from the response.
   
   - parameter success:    If the network reponse was successful.
   - parameter data:       The data contained in the reponse.
   - parameter response:   A callback once the response has been handled.
   */
  func handleUserSignUpResponse(data: AnyObject,
                                completion: SignUpCompletion) {
    // Attempt to parse the JSON response.
    let json = JSON(data)
    do {
      let response = try JSONParser.userSignUpReponse(json)
      completion(success: true, signUpResponse: response)
    } catch {
      completion(success: false, signUpResponse: nil)
    }
  }
  
  
  /**
   A user sign up response type. Attempts to represent a response
   that the server would give after an attempt at sign up a user.
   */
  struct UserSignUpResponse: NetworkReponseProtocol {
    var expires: String?
    var responseMessage: String?
    var success: Bool?
    var token: String?
    
    /**
     Checks the minimum amount of instance attributes that are needed
     for a comprehensible response are not nil.
     */
    func isValid() -> Bool {
      if (token != nil) {
        return true
      } else {
        return false
      }
    }
  }
}
