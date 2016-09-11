//
//  ProductImageView.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductImageView: UIImageView {
  
  init() {
    super.init(frame: CGRectZero)
    self.clipsToBounds = true
    self.contentMode = .ScaleAspectFit
    self.backgroundColor = UIColor.whiteColor()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
