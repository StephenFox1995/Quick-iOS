//
//  LoginManager.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginManager {
  
  fileprivate let network = Network()
  static let sharedInstance = LoginManager()
  
  /// Closure type for a auth response
  typealias AuthenticationCompletion = (_ success: Bool, _ session: Session?) -> Void
  
  func login(user: User, completion: @escaping AuthenticationCompletion) {
    let userJSON = JSON.UserEncoder.jsonifyUserForAuthentication(user)
    let loginJSON = JSON.UserEncoder.jsonifyUserObjectForAuthentication(userJSON)
    
    network.postJSON(NetworkingDetails.authenticateEndPoint, jsonParameters: loginJSON) {
      (success, data) in
      if success {
        NetworkResponse.UserAuthenticateResponse.handleResponse(data!, completion: {
          (success, authResponse) in
          if success {
            let sessionManager = SessionManager.sharedInstance
            do {
              try sessionManager
                .registerSessionFromAuthenticationResponse(authResponse!)
                .begin()
              let session = SessionManager.sharedInstance.activeSession
              completion(true, session)
            }
            catch {
              completion(false, nil)
            }
          }
          else {
            completion(false, nil)
          }
        })
      } else {
        // An error occurred during authentication.
        completion(false, nil)
      }
    }
  }
}
