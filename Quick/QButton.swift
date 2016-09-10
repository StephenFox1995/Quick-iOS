//
//  QButton.swift
//  QuickLoginViewController
//
//  Created by Stephen Fox on 06/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class QButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    self.backgroundColor = UIColor.qButtonBlueColor()
    self.layer.cornerRadius = 25.0
    self.clipsToBounds = true
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


extension UIButton {
  func addTextSpacing(spacing: CGFloat) {
    let attributedString = NSMutableAttributedString(string: self.currentTitle!)
    attributedString.addAttribute(NSKernAttributeName,
                                  value: spacing,
                                  range: NSRange(location: 0, length: self.currentTitle!.characters.count))
    self.titleLabel?.attributedText = attributedString
  }
}