//
//  Session.swift
//  Quick
//
//  Created by Stephen Fox on 15/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import JWTDecode

class Session {
  
  var token: UserJWT?
  var account: Account?
  
  /// Checks if the token for this session has expired.
  /// If there is not token then true is returned and the session is assumed to be expired.
  var isExpired: Bool {
    if let selfToken = self.token {
      if let token = selfToken.token {
        return token.expired
      }
    }
    return true
  }
  
  /**
   Creates a session object from a JSON Web Token.
   This method will attempt to retrieve all info for needed to
   created a `Session` object.
   
   - parameter token: The JWT token used to create the session.
   - returns: `Session` object.
   - throws: `UserJWTDecodeError.UnfoundClaim` when a JWT claim cannot be found.
   
   */
  static func sessionWithJWT(token: String) throws -> Session {
    // Create session object
    let session = Session()
    session.token = try UserJWT.decodeToken(token)
    
    // Attach account details to session; available through token.
    session.account = User(email: session.token!.email!,
                           firstname: session.token!.firstname!,
                           lastname: session.token!.lastname!,
                           password: nil)
    session.account!.id = session.token!.id
    return session
  }
  
  
  
  /**
   A struct to hold information about a user from a decoded JSON Web Token.
   */
  struct UserJWT {
    
    enum UserJWTDecodeError: ErrorType {
      case UnfoundClaim
    }
    
    var firstname: String?
    var lastname: String?
    var email: String?
    var id: String?
    /// A reference to the token that was used to created the struct.
    var token: JWT?
    var tokenString: String?
    
    /**
     Attempts to decode a JSON Web Token and retrieve all
     claims within the token associated for a user.
     
     - parameter token The JWT Token to decode.
     - returns `UserJWT` with all the field from
     
     */
    static func decodeToken(token: String) throws -> UserJWT? {
      let jwt = try decode(token)
      
      var userJWT = UserJWT()
      userJWT.tokenString = token
      userJWT.token = jwt
      
      userJWT.id = jwt.claim("id")
      guard userJWT.id != nil else {
        fxprint(StringConstants.unfoundJWTClaim + "id")
        throw UserJWTDecodeError.UnfoundClaim
      }
      userJWT.firstname = jwt.claim("firstname")
      guard userJWT.firstname != nil else {
        fxprint(StringConstants.unfoundJWTClaim + "firstname")
        throw UserJWTDecodeError.UnfoundClaim
      }
      userJWT.lastname = jwt.claim("lastname")
      guard userJWT.lastname != nil else {
        fxprint(StringConstants.unfoundJWTClaim + "lastname")
        throw UserJWTDecodeError.UnfoundClaim
      }
      userJWT.email = jwt.claim("email")
      guard userJWT.email != nil else {
        fxprint(StringConstants.unfoundJWTClaim + "email")
        throw UserJWTDecodeError.UnfoundClaim
      }
      return userJWT
    }
  }
  
  
  
}
