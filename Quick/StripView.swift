//
//  StripView.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class StripView: UIView {
  
  init() {
    super.init(frame: CGRectZero)
    self.setup()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  private func setup() {
    self.backgroundColor = UIColor.whiteColor()
    self.clipsToBounds = false
    self.layer.shadowOffset = CGSizeMake(0, 2)
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = UIColor.stripViewShadowColor().CGColor
    self.layer.shadowOpacity = 0.5
  }
}
