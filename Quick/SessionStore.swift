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
  let SESSION_USER_EMAIL = "Q_SESSION_EMAIL"
  let SESSION_USER_ID = "Q_SESSION_ID"
  
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
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var tokenDict: [String: AnyObject]?
    if let userEmail = defaults.objectForKey(SESSION_USER_EMAIL) as? String {
      tokenDict = self.read(userEmail)
    } else {
      return nil
    }
    
    var token: String?
    if let userID = defaults.objectForKey(SESSION_USER_ID) as? String {
      token = tokenDict![userID] as? String
    } else {
      return nil
    }
    
    
    do {
      return try Session.sessionWithJWT(token!)
    } catch {
      return Session()
    }
  }
  
  private func read(userEmail: String) -> [String: AnyObject]? {
    return Locksmith.loadDataForUserAccount(userEmail)
  }
}
