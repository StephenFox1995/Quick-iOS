//
//  SessionTests.swift
//  QuickApp
//
//  Created by Stephen Fox on 23/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//


import Quick
import Nimble
@testable import QuickApp

class SessionTests: QuickSpec {
  /**
    This token contains the following claims:
    {
      alg: "HS256",
      typ: "JWT"
    }.
    {
      email: "ss@gmail.com",
      id: "H1ErAhVc",
      firstname: "Stephen",
      lastname: "Fox",
      iat: 1471637545,
      exp: 1471673545
    }.
    [signature]
   */
  let mockToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNzQGdtYWlsLmNvbSIsImlkIjoiSDFFckFoVmMiLCJmaXJzdG5hbWUiOiJTdGVwaGVuIiwibGFzdG5hbWUiOiJGb3giLCJpYXQiOjE0NzE2Mzc1NDUsImV4cCI6MTQ3MTY3MzU0NX0.a7zDlPAbpglZYEzd-qxDjJhk4bUPh0M-RD73Bl_iSlI"
  
  struct mockClaims {
    static let alg = "HS2"
    static let typ = "JWT"
    static let email = "ss@gmail.com"
    static let id = "H1ErAhVc"
    static let firstname = "Stephen"
    static let lastname = "Fox"
    static let iat = 1471637545
    static let exp = 1471673545
  }
  
  override func setUp() {
    super.setUp()
  }
  
  override func spec() {
    describe("Create a session with a JSON Web Token") {
      var session: Session!
      it("Will be an expired JWT") {
        do {
            session = try Session.sessionWithJWT(self.mockToken)
        } catch { }
        // Expect the token to be expired.
        expect(session.isExpired).to(equal(true))
      }
      // Should still be able to extract the properties from the session instance even with the expired token
      it ("Should initialise the UserJWT property of the session and set the approptiate properties.") {
        expect(session.token!.id).to(equal(mockClaims.id))
        expect(session.token!.email).to(equal(mockClaims.email))
        expect(session.token!.firstname).to(equal(mockClaims.firstname))
        expect(session.token!.lastname).to(equal(mockClaims.lastname))
      }
      
      it("Should initialise a new Account object and set the appropriate properties with the claims.") {
        expect(session.account!.id).to(equal(mockClaims.id))
        expect(session.account!.email).to(equal(mockClaims.email))
        expect(session.account!.firstname).to(equal(mockClaims.firstname))
        expect(session.account!.lastname).to(equal(mockClaims.lastname))
      }
    }
  }
  
  
}
