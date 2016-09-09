//
//  BusinessSeeProductsView.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 09/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class BusinessSeeProductsButton: UIButton {

  init() {
    super.init(frame: CGRectZero)
    self.setupViews()
  }
  
  private func setupViews() {
    self.backgroundColor = UIColor.whiteColor()
    self.clipsToBounds = false
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = UIColor.businessSeeProductsShadowColor().CGColor
    self.layer.shadowOpacity = 0.5;
    self.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
    self.setTitle("SEE PRODUCTS", forState: .Normal)
    self.setTitleColor(UIColor.businessSeeProductsTitleNormalColor(), forState: .Normal)
    self.setTitleColor(UIColor.businessSeeProductsTitleHighlightedColor(), forState: .Highlighted)
    self.titleLabel?.setKernAmount(2.0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
