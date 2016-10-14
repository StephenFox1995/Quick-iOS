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
  fileprivate let userAccountKey = "com.quick.userAccountKey"
  
  enum SessionStoreError: Error {
    case missingKeys
  }
  
  /**
   Store session details within key chain so they can be used throughout the app.
   - parameter session: The session object to store.
   */
  func store(_ session: Session) throws {
    // Try store the session if a session already exists,
    // remove it and try store again
    do {
      try Locksmith.saveData(data: [session.account!.id!: session.token!.tokenString!], forUserAccount: self.userAccountKey)
    } catch LocksmithError.duplicate {
      if (self.removeSession()) {
        try self.store(session)
      }
    }
  }
  
  /**
   Checks if there is a stored session within keychain.
   - returns: `Session` object if there is a session stored in keychain, otherwise
   return nil.
   */
  func storedSession() -> Session? {
    if let tokenDict = self.read() { // Read using the user's email
      if let key = tokenDict.keys.first {
        if let t = tokenDict[key] as? String { // Get the token using the user's id.
          do {
            // Create a session from the token.
            return try Session.sessionWithJWT(t)
          } catch {
            return nil
          }
        }
      }
    }
    return nil
  }
  
 

  /**
   Removes any session that is currently stored on the device,
   regardless of whether it has expired or not.
   - returns: True - Succesful removal of session.
              False - Could not remove session, or could not find session.
   */
  func removeSession() -> Bool {
    do {
      try Locksmith.deleteDataForUserAccount(userAccount: self.userAccountKey)
      return true
    } catch {
      return false
    }
  }
  
  
  /**
   Read from keych ain the saved session.
   - parameter userEmail: The email of the users that owns the session.
   - returns: A dictionary object containing the session token as the value.
   */
  fileprivate func read() -> [String: AnyObject]? {
    return Locksmith.loadDataForUserAccount(userAccount: self.userAccountKey) as [String : AnyObject]?
  }

}
