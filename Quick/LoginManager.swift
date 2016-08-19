//
//  LoginManager.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class LoginManager {
  
  private let network = Network()
  static let sharedInstance = LoginManager()
  
  /// Closure type for a auth response
  typealias AuthenticationCompletion = (success: Bool, session: Session?) -> Void
  
  func login(user: User, completion: AuthenticationCompletion) {
    let userJSON = JSONEncoder.jsonifyUserForAuthentication(user)
    let loginJSON = JSONEncoder.jsonifyUserObjectForAuthentication(userJSON)
    
    network.postJSON(Network.NetworkingDetails.authenticateEndPoint, jsonParameters: loginJSON) {
      (success, data) in
      if success {
        let authNetworkResponse = NetworkResponse.UserAuthenticateResponse()
        authNetworkResponse.handleResponse(data, completion: {
          (success, authResponse) in
          if success {
            let sessionManager = SessionManager.sharedInstance
            do {
              try sessionManager.registerSessionFromAuthenticationResponse(authResponse!)
              try sessionManager.begin()
              let session = SessionManager.sharedInstance.activeSession
              completion(success: true, session: session!)
            }
            catch {
              completion(success: true, session: nil)
            }
          }
          else {
            completion(success: true, session: nil)
          }
        })
      } else {
        // An error occurred during authentication.
        completion(success: false, session: nil)
      }
    }
  }
}
