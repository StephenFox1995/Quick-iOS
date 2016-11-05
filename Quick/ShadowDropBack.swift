//
//  ShadowDropBack.swift
//  QuickApp
//
//  Created by Stephen Fox on 05/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ShadowDropBack: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
