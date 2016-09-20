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
  fileprivate let sessionManager = SessionManager.sharedInstance
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    /* 
     * Check if there is an active session on the device.
     * If there's no session ask the user to login/ signup.
     */
    if (!sessionManager.activeSessionAvailable()) {
      let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let navigationController: UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
      let rootViewController = AuthenticateViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal, options: nil)
      rootViewController.authDelegate = self
      navigationController.viewControllers = [rootViewController]
      self.window?.rootViewController = navigationController
      return true
    }
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }


}

// MARK: SignUpLoginViewControllerDelegate
extension AppDelegate {
  /// Login
  func authenticateViewControllerLoginDetailsEntered(_ viewController: AuthenticateViewController,
                                                     email: String,
                                                     password: String) {
    let loginManager = LoginManager.sharedInstance
    
    let user = User()
    user.email = email
    user.password = password
    
    loginManager.login(user: user) { (success, session) in
      if success {
        self.displayHomeViewController()
      } else {
        return self.displayMessage(title: StringConstants.error,
                                   message: StringConstants.invalidCredential)
      }
    }
  }
  /// SignUp
  func authenticateViewControllerSignUpDetailsEntered(_ viewController: AuthenticateViewController,
                                                      email: String,
                                                      fullname: String,
                                                      password: String) {
    let signUpManager = SignUpManager.sharedInstace
    let user = User(email: email, firstname: fullname, lastname: fullname, password: password)
    
    signUpManager.createUserAccount(user: user) { (success, session) in
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
  fileprivate func displayHomeViewController() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let rootViewController = self.window?.rootViewController as! UINavigationController
    let homeViewController = sb.instantiateViewController(withIdentifier: StringConstants.homeViewController)
    rootViewController.pushViewController(homeViewController, animated: false)
  }
  
  fileprivate func displayMessage(title: String, message: String) {
    let alertController = UIAlertController(title: title,
                                            message:message,
                                            preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Done",
      style: UIAlertActionStyle.default,
      handler: nil))
    let rootViewController = self.window?.rootViewController as! UINavigationController
    rootViewController.present(alertController, animated: true, completion: nil)
  }
}

