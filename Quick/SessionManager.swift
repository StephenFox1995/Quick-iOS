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
   Creates a new session on a user's device.
   */
  func registerSession(session: Session) {
    
  }
}
