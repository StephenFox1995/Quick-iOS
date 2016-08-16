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
  let testToken: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdG5hbWUiOiJTdGVwaGVuICIsImxhc3RuYW1lIjoiRm94IiwiZW1haWwiOiJ0ZXN0QHRlc3QuY29tIiwiaWQiOiJCa2ljUjJ5OSIsImlhdCI6MTQ3MTI5OTIxOCwiZXhwIjoxNDcxMzM1MjE4fQ.3nImk-jANR-W56zdQ03PA9jNFqd2css9bL4g1UKecu8"
  var jwt: UserJWT?
  var account: Account?
  
  /**
   Creates a session object from a JSON Web Token.
   This method will attempt to retrieve all info for a use
   
   - parameter token The JWT token used to create the session.
   - returns `Session` object.
   */
  static func sessionWithJWT(token: String) throws -> Session {
    // Create session object
    let session = Session()
    session.jwt = try UserJWT.decodeToken(token)
    
    // Attach account details to session; available through token.
    session.account = User(email: session.jwt!.email!,
                           firstname: session.jwt!.firstname!,
                           lastname: session.jwt!.lastname!,
                           password: nil)
    return session
  }
  
  
  /**
   A struct to hold information about a user which is to be decoded from a JSON Web Token.
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
    
    /**
     Attempts to decode a JSON Web Token and retrieve all
     claims within the token associated for a user.
     
     - parameter token The JWT Token to decode.
     - returns `UserJWT` with all the field from
     
     */
    static func decodeToken(token: String) throws -> UserJWT? {
      let jwt = try decode(token)
      
      var userJWT = UserJWT()
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
