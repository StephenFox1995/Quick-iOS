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
  var activeSession: Session?
  private let sessionStore = SessionStore.sharedInstance
  
  
  /**
   Checks to see if there is an active session available on the device.
   - returns: True if an active session has been found in keychain.
              False if not active session was found.
   */
  func activeSessionAvailable() -> Bool {
    if let session = self.sessionStore.storedSession() {
      // Now check if the token is still valid.
      if session.isExpired {
        self.removeInactiveSession() // Remove that session as it has expired.
        return false // Session is has expired.
      } else {
        self.activeSession = session
        return true
      }
    } else {
      return false
    }
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
    // Store the pending session.
    self.storeSession(self.pendingSession)
  }
  
  
  private func storeSession(session: Session) {
    do {
      try self.sessionStore.store(session)
    } catch {
      
    }
  }
  
  
  private func removeInactiveSession() {
    self.sessionStore.removeInactiveSession()
  }
}
