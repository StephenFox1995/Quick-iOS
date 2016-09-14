//
//  AppDelegate.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder,
UIApplicationDelegate,
AuthenticateViewControllerDelegate {
  
  // Indicates if we're in development environment.
  static let devEnvironment = true
  private let sessionManager = SessionManager.sharedInstance
  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    /* 
     * Check if there is an active session on the device.
     * If there's no session ask the user to login/ signup.
     */
    if (!sessionManager.activeSessionAvailable()) {
      let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let navigationController: UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
      let rootViewController = AuthenticateViewController(transitionStyle: .Scroll,
                                                          navigationOrientation: .Horizontal, options: nil)
      rootViewController.authDelegate = self
      navigationController.viewControllers = [rootViewController]
      self.window?.rootViewController = navigationController
      return true
    }
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
  }

  func applicationDidEnterBackground(application: UIApplication) {
  }

  func applicationWillEnterForeground(application: UIApplication) {
  }

  func applicationDidBecomeActive(application: UIApplication) {
  }

  func applicationWillTerminate(application: UIApplication) {
  }


}

// MARK: SignUpLoginViewControllerDelegate
extension AppDelegate {
  /// Login
  func authenticateViewControllerLoginDetailsEntered(viewController: AuthenticateViewController,
                                                     email: String,
                                                     password: String) {
    let loginManager = LoginManager.sharedInstance
    
    let user = User()
    user.email = email
    user.password = password
    
    loginManager.login(user) { (success, session) in
      if success {
        self.displayHomeViewController()
      } else {
        return self.displayMessage(title: StringConstants.error,
                                   message: StringConstants.invalidCredential)
      }
    }
  }
  /// SignUp
  func authenticateViewControllerSignUpDetailsEntered(viewController: AuthenticateViewController,
                                                      email: String, fullname: String,
                                                      password: String) {
    let signUpManager = SignUpManager.sharedInstace
    let user = User(email: email, firstname: fullname, lastname: fullname, password: password)
    
    signUpManager.createUserAccount(user) { (success, session) in
      if success {
        self.displayHomeViewController()
      } else {
        return self.displayMessage(title: StringConstants.error,
                                   message: StringConstants.accountTaken)
      }
    }
  }
}

extension AppDelegate {
  private func displayHomeViewController() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let rootViewController = self.window?.rootViewController as! UINavigationController
    let homeViewController = sb.instantiateViewControllerWithIdentifier(StringConstants.homeViewController)
    rootViewController.pushViewController(homeViewController, animated: false)
  }
  
  private func displayMessage(title title: String, message: String) {
    let alertController = UIAlertController(title: title,
                                            message:message,
                                            preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "Done",
      style: UIAlertActionStyle.Default,
      handler: nil))
    let rootViewController = self.window?.rootViewController as! UINavigationController
    rootViewController.presentViewController(alertController, animated: true, completion: nil)
  }
}

