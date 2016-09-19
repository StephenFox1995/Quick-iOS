//
//  FavouriteButton.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 08/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class FavouriteButton: UIButton {
  
  init() {
    super.init(frame: CGRect.zero)
    self.titleLabel?.font = UIFont.fontAwesomeOfSize(40)
    self.setTitleColor(UIColor.favouriteButtonNormalRedColor(), for: UIControlState())
    self.setTitleColor(UIColor.favouriteButtonHighlightedRedColor(), for: .highlighted)
    self.setTitle(String.fontAwesomeIconWithCode("fa-heart-o"), for: .Normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
