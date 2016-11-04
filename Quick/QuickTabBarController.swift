//
//  QuickTabBarController.swift
//  QuickApp
//
//  Created by Stephen Fox on 20/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class QuickTabBarController: UITabBarController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // http://stackoverflow.com/questions/20979281/ios-7-tabbar-translucent-issue/26419986#26419986
    self.tabBar.isTranslucent = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
