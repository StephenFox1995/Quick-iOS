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
    self.titleLabel?.font = UIFont.qFontDemiBold(16)
    self.backgroundColor = UIColor.qButtonBlueColor()
    self.titleLabel?.textColor = UIColor.white
    self.clipsToBounds = true
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


