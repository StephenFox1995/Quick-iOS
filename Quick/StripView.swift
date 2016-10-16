//
//  StripView.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class StripView: UIView {
  
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
    self.clipsToBounds = false
    self.layer.shadowOffset = CGSize(width: 0, height: 2)
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = UIColor.stripViewShadowColor().cgColor
    self.layer.shadowOpacity = 0.5
    
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
