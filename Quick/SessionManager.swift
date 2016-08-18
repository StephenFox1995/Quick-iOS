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
    let sessionStore = SessionStore.sharedInstance
    
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
  
  /**
   Begins the session. Once a session has begun, this session will be used for all network requests etc.
   This is the equivalent of logging a user in to the app.
   */
  func begin() {
    guard pendingSession != nil else {
      return
    }
  }
  
  
  private func storeSession(session: Session) {
    let sessionStore = SessionStore.sharedInstance
    do {
      try sessionStore.store(self.pendingSession)
    } catch {
      
    }
  }
}
