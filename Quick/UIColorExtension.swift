//
//  Color.swift
//  QuickApp
//
//  Created by Stephen Fox on 09/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
/**
 * When adding new colors use two decimal places for all components.
 * e.g.
 *  red:   0.36
 *  green: 0.52
 *  blue:  0.89
 */


/// BusinessViewController
extension UIColor {
  static func businessViewControllerBackgroundGray() -> UIColor {
    return UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
  }
}

/// BusinessHoursView
extension UIColor {
  static func businessHoursViewGreen() -> UIColor {
    return UIColor(red: 0.48, green: 0.75, blue: 0.17, alpha: 1.00)
  }
  static func businessHoursViewRed() -> UIColor {
    return UIColor(red: 0.99, green: 0.40, blue: 0.40, alpha: 1.00)
  }
}

/// BusinessInfoStrip
extension UIColor {
  static func businessInfoStripShadowColor() -> UIColor {
    return UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 0.50)
  }
  static func businessInfoStripSeparatorColor() -> UIColor {
    return UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 0.50)
  }
}

/// BusinessSeeProductsButton
extension UIColor {
  static func businessSeeProductsShadowColor() -> UIColor {
    return UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 0.50)
  }
  static func businessSeeProductsTitleNormalColor() -> UIColor {
    return UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
  }
  static func businessSeeProductsTitleHighlightedColor() -> UIColor {
    return UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
  }
}

/// BusinessWaitingTimeView
extension UIColor {
  static func businessWaitingTimeViewGrayColor() -> UIColor {
    return UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
  }
}

/// FavouriteButton
extension UIColor {
  static func favouriteButtonNormalRedColor() -> UIColor {
    return UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.00)
  }
  static func favouriteButtonHighlightedRedColor() -> UIColor {
    return UIColor(red: 0.98, green: 0.22, blue: 0.22, alpha: 1.00)
  }
}

/// QButton
extension UIColor {
  static func qButtonBlueColor() -> UIColor {
    return UIColor(red: 0.29, green: 0.56, blue: 0.88, alpha: 1.00)
  }
}

/// QTextField
extension UIColor {
  static func qTextFieldBlueColor() -> UIColor {
    return UIColor(red: 0.29, green: 0.56, blue: 0.88, alpha: 1.00)
  }
  static func qTextFieldGrayColor() -> UIColor {
    return UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
  }
}

/// UIPageControlExtensions
extension UIColor {
  static func pageControlGrayColor() -> UIColor {
    return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.50)
  }
  static func pageControlCurrentPageGrayColor() -> UIColor {
    return UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1.00)
  }
}


