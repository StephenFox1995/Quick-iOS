//
//  StripView.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class StripView: UIView, UIViewShadow {
  
  var button: UIButton?
  
  init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }
  
  /**
   Intialise a new `StripView` with a button.
   - parameter button The button to add to the stripview.
   */
  init(withButton button: UIButton) {
    super.init(frame: CGRect.zero)
    self.button = button
    self.addSubview(button)
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
  
  fileprivate func setup() {
    self.backgroundColor = UIColor.white
    self.addShadow()
    self.clipsToBounds = false
    
    // Set Layout constraints for buttons.
    if let button = self.button {
      constrain(self, button) {
        (superView, button) in
        button.center == superView.center
        button.width == superView.width
        button.height == superView.height
      }
    }
    
  }
}
