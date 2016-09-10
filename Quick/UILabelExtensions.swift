//
//  UILabelExtensions.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

extension UILabel {
  ///Sets the kerning amount for the views `titleLabel` property
  func setKernAmount(kernAmount: CGFloat) {
    var labelFont: UIFont!
    if let font = self.font {
      labelFont = font
    } else {
      labelFont = UIFont(name: "HelveticaNeue-Light", size: 20)!
    }
    var labelText: String!
    if let text = self.text {
      labelText = text
    } else {
      labelText = ""
    }
    
    let attributes: NSDictionary = [
      NSFontAttributeName:labelFont,
      NSForegroundColorAttributeName:UIColor.whiteColor(),
      NSKernAttributeName:CGFloat(kernAmount)
    ]
    let attributedText = NSAttributedString(string: labelText, attributes: attributes as? [String : AnyObject])
    self.attributedText = attributedText
    self.sizeToFit()
  }
}
