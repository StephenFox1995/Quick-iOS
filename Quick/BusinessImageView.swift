//
//  BusinessImageView.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class BusinessImageView: UIImageView {
  private var imageLabel: BusinessViewImageLabel!

  
  init(businessName: String, businessLocation: String) {
    super.init(frame: CGRectZero)
    self.clipsToBounds = true
    self.contentMode = .ScaleAspectFill
    
    self.imageLabel = BusinessViewImageLabel(businessName: businessName, businessLocation: businessLocation)
    self.addSubview(self.imageLabel)
    self.bringSubviewToFront(self.imageLabel)
    
    constrain(self, self.imageLabel) {
      (superView, imageLabel) in
      imageLabel.leading == superView.leading
      imageLabel.height == superView.height * 0.3
      imageLabel.width == superView.width * 0.95
      imageLabel.bottom == superView.bottom - 20
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
