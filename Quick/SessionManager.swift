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
  fileprivate var pendingSession: Session!
  var activeSession: Session?
  fileprivate let sessionStore = SessionStore.sharedInstance
  
  fileprivate init() {}
  
  /**
   Checks to see if there is an active session available on the device.
   - returns: True if an active session has been found in keychain.
              False if no active session was found.
   */
  func activeSessionAvailable() -> Bool {
    if let session = self.sessionStore.storedSession() {
      // Now check if the token is still valid.
      if session.isExpired {
        return !self.removeExpiredSession() // Remove that session as it has expired.
      } else {
        self.activeSession = session
        return true
      }
    } else {
      return false
    }
  }
  
  
  func getTokenString() -> String? {
    if let tokenString = SessionManager.sharedInstance.activeSession!.token?.tokenString {
      return tokenString
    }
    return nil
  }
  
  
  /**
   Attempts to register a session from a `NetworkResponse.UserSignUpResponse`.
   - parameter signUpResponse: A sign up response.
   */
  func registerSessionFromSignUpResponse(_ signUpResponse: NetworkResponse.UserSignUpResponse) throws -> SessionManager {
    // Create session object.
    let session = try Session.sessionWithJWT(signUpResponse.token!)
    self.pendingSession = session
    return self
  }
  
  /**
   Attempts ot register a session from a `NetworkResponse.UserAuthenticateResponse`.
   - parameter authResponse: The authentication response.
   */
  func registerSessionFromAuthenticationResponse(_ authResponse: NetworkResponse.UserAuthenticateResponse) throws -> SessionManager {
    // Create session object
    let session = try Session.sessionWithJWT(authResponse.token!)
    self.pendingSession = session
    return self
  }
  
  
  /**
   Begins the session. Once a session has begun, this session will be used for all network requests etc.
   This is the equivalent of logging a user in to the app.
   */
  func begin() throws {
    guard self.pendingSession != nil else {
      return
    }
    // Attempt to store the pending session.
    try self.storeSession(self.pendingSession)
    self.activeSession = self.pendingSession
  }
  
  
  /**
   Attempts to store the session withing `SessionStore`
   - paramter session: The session to store.
   */
  fileprivate func storeSession(_ session: Session) throws {
    try self.sessionStore.store(session)
  }
  
  
  /**
   Removes any expired sessions on the device.
   - returns: True - successfully removed inactive session.
              False - Either could not find session to delete of
                      session was not inactive.
   */
  fileprivate func removeExpiredSession() -> Bool {
    return self.sessionStore.removeSession()
  }
  
  /**
   Removes any session that is currently stored on the device,
   regardless of whether it has expired or not.
   - returns: True - Succesful removal of session.
              False - Could not remove session, or could not find session.
   */
  // MARK: TODO: By default assume session was removed, and declare a
  //             throws, and raise exception if there was an error.
  func removeSession() -> Bool {
    return self.sessionStore.removeSession()
  }
}
