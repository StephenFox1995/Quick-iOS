//
//  SignUpManager.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class SignUpManager {
  
  private var network = Network()
  static let sharedInstace = SignUpManager()
  
  
  /**
   Attempts to create a user account.
   - parameter user A user object with information on the user for account creation
   - parameter completionHandler Completion handler.
   */
  func createUserAccount(user: User,
                         completetionHandler: (success: Bool) -> Void) {
    let userJSON = JSONEncoder.encodeUser(user)
    let userJSONObject = JSONEncoder.createUserJSONObject(userJSON);
    
    network.postJSON(Network.NetworkingDetails.createUserEndPoint,
                     jsonParameters: userJSONObject)
    { (success, data) in
      
    }
  }
}
