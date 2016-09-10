//
//  UIButtonExtensions.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit


extension UIButton {
  func addTextSpacing(spacing: CGFloat) {
    let attributedString = NSMutableAttributedString(string: self.currentTitle!)
    attributedString.addAttribute(NSKernAttributeName,
                                  value: spacing,
                                  range: NSRange(location: 0, length: self.currentTitle!.characters.count))
    self.titleLabel?.attributedText = attributedString
  }
}