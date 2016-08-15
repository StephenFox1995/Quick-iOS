//
//  AppDelegate.swift
//  Quick
//
//  Created by Stephen Fox on 28/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // Indicates if we're in development environment.
  static let devEnvironment = true
  private let sessionManager = SessionManager()
  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Check if there is an active session on the device.
    // If there's no session ask the user to login/ signup.
    if (!sessionManager.getActiveSession()) {
      // Override point for customization after application launch.
      let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
      
      let rootViewController:UIViewController = storyboard.instantiateViewControllerWithIdentifier("SignUpViewController") as UIViewController
      navigationController.viewControllers = [rootViewController]
      self.window?.rootViewController = navigationController
      return true
    }
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

