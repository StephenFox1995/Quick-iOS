//
//  JSONParserTests.swift
//  QuickApp
//
//  Created by Stephen Fox on 20/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import Quick
import Nimble
@testable import QuickApp
@testable import SwiftyJSON

class JSONParserTests: QuickSpec {
  
  override func setUp() {
    super.setUp()
  }
  
  override func spec() {
    describe("A successful SignUpResponse") {
      it("parse a sign up response and return a valid NetworkResponse.UserSignUpResponse") {
        let data = JSON(MockJSON.init().validMockUserSignUpResponse())
        do {
          let userSignUpResponse = try JSONParser.userSignUpReponse(data)
          expect(userSignUpResponse.isValid()).to(equal(true))
        } catch { }
      }
    }
    
    describe("A successful AuthenticationResponse") {
      it("parse a auth response and return a valid NetworkResponse.UserAuthenticateResponse") {
        let data = JSON(MockJSON.init().validMockUserAuthReponse())
        do {
          let authResponse = try JSONParser.userAuthenticate(data)
          expect(authResponse.isValid()).to(equal(true))
        } catch { }
      }
    }
  }
  
  
  /// Mock JSON
  fileprivate struct MockJSON {
    
    let mockToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNzQGdtYWlsLmNvbSIsImlkIjoiSDFFckFoVmMiLCJmaXJzdG5hbWUiOiJTdGVwaGVuIiwibGFzdG5hbWUiOiJGb3giLCJpYXQiOjE0NzE2Mzc1NDUsImV4cCI6MTQ3MTY3MzU0NX0.a7zDlPAbpglZYEzd-qxDjJhk4bUPh0M-RD73Bl_iSlI"
    
    func validMockUserSignUpResponse() -> [String: AnyObject] {
      return ["expires": "10h" as AnyObject,
              "responseMessage": "Successful Sign Up" as AnyObject,
              "success": true as AnyObject,
              "token": self.mockToken as AnyObject]
    }
    func validMockUserAuthReponse() -> [String: AnyObject] {
      return ["expires": "10h" as AnyObject,
              "responseMessage": "Successful Sign Up" as AnyObject,
              "success": true as AnyObject,
              "token": self.mockToken as AnyObject]
    }
    
  }
  
}
