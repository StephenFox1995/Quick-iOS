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
  
  /**
   Store session details within key chain so they can be used throughout the app.
   - parameter session: The session object to store.*/
  func store(session: Session) throws {
    try Locksmith.saveData([session.account!.id!: session.token!.tokenString!], forUserAccount: session.account!.email!)  
  }
  
  func read(userAccountEmail: String) -> [String: AnyObject]? {
    return Locksmith.loadDataForUserAccount(userAccountEmail)
  }
}
