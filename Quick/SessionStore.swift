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
   Removes */
  func removeInactiveSession() {
    do {
      let sessionKeys = try self.sessionDictionaryKeys();
      let userEmail = sessionKeys.0
      // Delete session from keychain.
      try Locksmith.deleteDataForUserAccount(userEmail)
      // Remove user email and id from `NSUserDefaults`
      let userDefaults = NSUserDefaults.standardUserDefaults()
      userDefaults.removeObjectForKey(self.SESSION_USER_EMAIL)
      userDefaults.removeObjectForKey(self.SESSION_USER_ID)
    } catch {
      return // No keys available.
    }
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
}
