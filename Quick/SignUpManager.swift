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
   - parameter user: A user object with information on the user for account creation
   - parameter completion: Completion handler.
   */
  func createUserAccount(user: User,
                         completion: NetworkResponse.SignUpCompletion) {
    let userJSON = JSONEncoder.encodeUser(user)
    let userJSONObject = JSONEncoder.createUserJSONObject(userJSON);
    
    network.postJSON(Network.NetworkingDetails.createUserEndPoint,
                     jsonParameters: userJSONObject)
    { (success, data) in
      if success {
        // Pass control to network reponse to handle and parse the response.
        let networkReponse = NetworkResponse()
        networkReponse.handleUserSignUpResponse(data, completion: self.sessionSetUpClosure)
      } else {
        // An error occurred during account creation.
        completion(success: false, signUpResponse: nil)
      }
    }
  }
  
  /// Closure constant to handle setting up sessions after sign up.
  private let sessionSetUpClosure : NetworkResponse.SignUpCompletion = {
    success, signUpResponse in
    if success {
      // Once the data has been handled and parsed, begin a new session.
      let sessionManager = SessionManager.sharedInstance
      
      do {
        try sessionManager.registerSessionFromSignUpResponse(signUpResponse!)
        sessionManager.begin()
      } catch {
        
      }
    }
  }
  
}
