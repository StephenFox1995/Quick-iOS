//
//  SessionStore.swift
//  Quick
//
//  Created by Stephen Fox on 18/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Locksmith

class SessionStore {
  static let sharedInstance = SessionStore()
  private let SESSION_USER_EMAIL = "Q_SESSION_EMAIL"
  private let SESSION_USER_ID = "Q_SESSION_ID"
  
  enum SessionStoreError: ErrorType {
    case MissingKeys
  }
  
  /**
   Store session details within key chain so they can be used throughout the app.
   - parameter session: The session object to store.*/
  func store(session: Session) throws {
    try Locksmith.saveData([session.account!.id!: session.token!.tokenString!], forUserAccount: session.account!.email!)
    // MARK: Check security with this.
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(session.account!.email!, forKey: SESSION_USER_EMAIL)
    defaults.setObject(session.account!.id!, forKey: SESSION_USER_ID)
  }
  
  /**
   Checks if there is a stored session within keychain.
   - returns: `Session` object if there is a session stored in keychain, otherwise
   return nil.
   */
  func storedSession() -> Session? {
    var sessionKeys: (String, String)!
    
    do {
      // Get the keys for accessing the session.
      sessionKeys = try self.sessionDictionaryKeys()
    } catch {
      return nil
    }
    
    let userEmail = sessionKeys.0
    if let tokenDict = self.read(userEmail) { // Read using the user's email
      let userID = sessionKeys.1
      if let token = tokenDict[userID] as? String { // Get the token using the user's id.
        do {
          // Create a session from the token.
          return try Session.sessionWithJWT(token)
        } catch {
          return nil
        }
      }
    }
    return nil
  }
  
  /**
   Removes the session iff expired.
   - returns: True: if the session was expired and successfully removed.
              False: The session was not expired so was not removed or there
                     was no session found.*/
  func removeExpiredSession() -> Bool {
    do {
      let sessionKeys = try self.sessionDictionaryKeys()
      let userEmail = sessionKeys.0
      let userID = sessionKeys.1
      var session: Session!
      
      if let tokenDict = self.read(userEmail) {
        // Read token string and make sure it has actually expired.
        if let tokenString = self.readTokenString(userEmail, userID: userID, dict: tokenDict) {
          // Create a session object so we can check if it has expired.
          session = try Session.sessionWithJWT(tokenString)
        }
      }
      
      // Only delete if expired.
      guard session.isExpired else {
        return false
      }
      // Delete session from keychain.
      try Locksmith.deleteDataForUserAccount(userEmail)
      // Remove user email and id from `NSUserDefaults`
      self.removeSessionDictionaryKeys()
      return true
    } catch {
      return false // No keys available.
    }
  }
  
  /**
   Removes any session that is currently stored on the device,
   regardless of whether it has expired or not.
   - returns: True - Succesful removal of session.
              False - Could not remove session, or could not find session.
   */
  func removeSession() -> Bool {
    do {
      let sessionKeys = try self.sessionDictionaryKeys()
      let userEmail = sessionKeys.0
      try Locksmith.deleteDataForUserAccount(userEmail)
      self.removeSessionDictionaryKeys()
      return true
    } catch {
      return false
    }
  }
  
  

  ///Removes dictionary keys used to access sessions on the device.
  private func removeSessionDictionaryKeys() {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    // Remove Email
    userDefaults.removeObjectForKey(self.SESSION_USER_EMAIL)
    // Remove ID
    userDefaults.removeObjectForKey(self.SESSION_USER_ID)
  }
  
  
  /**
   Trys to read the dictionary keys for accessing session info from keychain.
   - returns: Tuple containing `(UserEmailKey?, UserIdKey?)`
   - throws: `SessionStoreError.MissingKeys` if no keys can be found.
   */
  private func sessionDictionaryKeys() throws -> (String, String) {
    let defaults = NSUserDefaults.standardUserDefaults()
    var email: String
    var id: String
    if let userEmail = defaults.objectForKey(self.SESSION_USER_EMAIL) as? String {
      email = userEmail
    } else {
      throw SessionStoreError.MissingKeys
    }
    if let userID = defaults.objectForKey(self.SESSION_USER_ID) as? String {
      id = userID
    } else {
      throw SessionStoreError.MissingKeys
    }
    return (email, id)
  }
  
  
  
  /**
   Read from keychain the saved session.
   - parameter userEmail: The email of the users that owns the session.
   - returns: A dictionary object containing the session token as the value.
   */
  private func read(userEmail: String) -> [String: AnyObject]? {
    return Locksmith.loadDataForUserAccount(userEmail)
  }
  
  /**
   Attempts to read the dictionary object returned from `read(_: String)`
   to extract the token string.
   - parameter userEmail: The email associated with the token.
   - paremeter userID: The id of the user.
   - parameter dict: The dictionary object that contains the token.
   - returns: If the token was found it will be returned, otherwise nil.
   */
  private func readTokenString(userEmail: String,
                               userID: String,
                               dict: [String: AnyObject]?) -> String? {
    if let tokenDict = self.read(userEmail) { // Read using the user's email
      if let token = tokenDict[userID] as? String { // Get the token using the user's id.
        do {
          // Create a session from the token.
          return try Session.sessionWithJWT(token).token?.tokenString
        } catch {
          return nil
        }
      }
    }
    return nil
  }
}
