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
    super.init(frame: CGRectZero)
    self.titleLabel?.font = UIFont.fontAwesomeOfSize(40)
    self.setTitleColor(UIColor.favouriteButtonNormalRedColor(), forState: .Normal)
    self.setTitleColor(UIColor.favouriteButtonHighlightedRedColor(), forState: .Highlighted)
    self.setTitle(String.fontAwesomeIconWithCode("fa-heart-o"), forState: .Normal)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
