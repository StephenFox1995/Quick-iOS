//
//  SignUpManager.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class SignUpManager {
  
  private let network = Network()
  static let sharedInstace = SignUpManager()
  
  /// Closure type for a sign up response
  typealias SignUpCompletion = (success: Bool, session: Session?) -> Void
  
  /**
   Attempts to create a user account.
   - parameter user: A user object with information on the user for account creation
   - parameter completion: Completion handler.
   */
  func createUserAccount(user: User,
                         completion: SignUpCompletion) {
    let userJSON = JSONEncoder.encodeUser(user)
    let userJSONObject = JSONEncoder.createUserJSONObject(userJSON);
    
    network.postJSON(Network.NetworkingDetails.createUserEndPoint,
                     jsonParameters: userJSONObject)
    { (success, data) in
      if success {
        
        // Pass control to network reponse to handle and parse the response.
        let userSignUpNetworkReponse = NetworkResponse.UserSignUpResponse()
        userSignUpNetworkReponse.handleUserSignUpResponse(data, completion:
          { (success, signUpResponse) in
            if success {
              // Once the data has been handled and parsed, begin a new session.
              let sessionManager = SessionManager.sharedInstance
              do {
                try sessionManager.registerSessionFromSignUpResponse(signUpResponse!)
                try sessionManager.begin()
                let session = SessionManager.sharedInstance.activeSession
                completion(success: true, session: session)
              }
              catch {
                completion(success: false, session: nil)
              }
            }
            else {
              completion(success: false, session: nil)
            }
        })
      }
      else {
        // An error occurred during account creation.
        completion(success: false, session: nil)
      }
    }
  }
}
