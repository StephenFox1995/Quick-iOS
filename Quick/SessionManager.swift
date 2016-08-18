//
//  SessionManager.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class SessionManager {
  static let sharedInstance = SessionManager()
  
  /// Session object that has not yet been activated.
  private var pendingSession: Session!
  
  func getActiveSession() -> Bool {
    // TODO: Look somewhere for a session.
    // Somewhere in an enrypted store.
    // Check if the token is still valid.
    // If token valid, then we have active session
    // otherwise we dont have active session
    // and we need to request the user to login
    // again and get a new token they can use.
    return false
  }
  
  
  /**
   Attempts to register a session from a `NetworkResponse.UserSignUpResponse`.
   - parameter signUpResponse A sign up response.
   */
  func registerSessionFromSignUpResponse(signUpResponse: NetworkResponse.UserSignUpResponse) throws {
    // Create session object.
    let session = try Session.sessionWithJWT(signUpResponse.token!)
    self.pendingSession = session
  }
  
  
  func begin() {
    guard pendingSession != nil else {
      return
    }
  }
  
  

}
