//
//  UIStoryboardExtensions.swift
//  Quick
//
//  Created by Stephen Fox on 02/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

extension UIStoryboard {
  static func viewControllerFromStoryboard(identifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewControllerWithIdentifier(identifier)
  }
}
