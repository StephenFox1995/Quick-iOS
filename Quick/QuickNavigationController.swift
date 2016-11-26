//
//  QuickNavigationController.swift
//  QuickApp
//
//  Created by Stephen Fox on 05/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class QuickNavigationController: UINavigationController {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupViews()
  }
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    self.setupViews()
  }
  override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
    super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    self.setupViews()
  }
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    self.navigationBar.barTintColor = UIColor.white
    self.navigationBar.isTranslucent = false
  }
}


