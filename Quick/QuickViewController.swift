//
//  QuickViewController.swift
//  Quick
//
//  Created by Stephen Fox on 02/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit


class QuickViewController: UIViewController {
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.view.backgroundColor = UIColor.whiteColor()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  /**
   Displays an alert to the user.
   
   - parameter message: The message use in the alert.
   */
  internal func displayMessage(title title: String, message: String) {
    let alertController = UIAlertController(title: title,
                                            message:message,
                                            preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "Done",
      style: UIAlertActionStyle.Default,
      handler: nil))
    self.presentViewController(alertController, animated: true, completion: nil)
  }
}
