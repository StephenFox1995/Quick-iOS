//
//  NetworkResponseTests.swift
//  QuickApp
//
//  Created by Stephen Fox on 23/08/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import QuickApp

class NetworkResponseTests: QuickSpec {
  
  override func setUp() {
    super.setUp()
  }
  
  override func spec() {
    describe("Get UserSignUpResponse to handle a network reponse from signing up.") {
      it ("Should handle the response successfully.") {
        let mockNetworkResponseType = MockNetworkResponses.init()
        let mockNetworkResponseData = mockNetworkResponseType.mockNetworkUserSignUpResponse()
        NetworkResponse.UserSignUpResponse.handleUserSignUpResponse(mockNetworkResponseData,
                                                                      completion: {
                                                                        (success, signUpResponse) in
          // Expect he response to be valid.
          expect(signUpResponse!.isValid()).to(equal(true))
          // Also expect all the properties to be set.
          expect(signUpResponse!.expires).to(equal(mockNetworkResponseType.expiresValue))
          expect(signUpResponse!.responseMessage).to(equal(mockNetworkResponseType.responseMessageValue))
          expect(signUpResponse!.token).to(equal(mockNetworkResponseType.tokenValue))
          expect(signUpResponse!.success).to(equal(mockNetworkResponseType.successValue))
        })
      }
    }
    
    describe("Get UserAuthenticationResponse to handle a network response from authenticating.") {
      it ("Should handle the response successfully") {
        let mockNetworkResponseType = MockNetworkResponses.init()
        let mockNetworkResponseData = mockNetworkResponseType.mockNetworkAuthResponse()
        NetworkResponse.UserAuthenticateResponse.handleResponse(mockNetworkResponseData, completion: {
          (success, authResponse) in
          // Expect the reponse to be valid.
          expect(authResponse!.isValid()).to(equal(true))
          // Also expect all the properties to be set.
          expect(authResponse!.expires).to(equal(mockNetworkResponseType.expiresValue))
          expect(authResponse!.responseMessage).to(equal(mockNetworkResponseType.responseMessageValue))
          expect(authResponse!.token).to(equal(mockNetworkResponseType.tokenValue))
          expect(authResponse!.success).to(equal(mockNetworkResponseType.successValue))
        })
      }
    }
  }
  
  struct MockNetworkResponses {
    let expiresValue = "10hrs"
    let responseMessageValue = "User Sign Up Successful"
    let tokenValue = "someTokenValue"
    let successValue = true
    
    func mockNetworkUserSignUpResponse() -> AnyObject {
      return ["expires": expiresValue,
              "responseMessage": responseMessageValue,
              "token": tokenValue,
              "success": successValue];
    }
    
    func mockNetworkAuthResponse() -> AnyObject {
      return ["expires": expiresValue,
              "responseMessage": responseMessageValue,
              "token": tokenValue,
              "success": successValue];
    }
  }
  
}
