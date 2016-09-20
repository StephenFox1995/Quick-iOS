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
    super.init(frame: CGRect.zero)
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    self.backgroundColor = UIColor.white
    self.clipsToBounds = false
    self.layer.shadowOffset = CGSize(width: 0, height: 2);
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = UIColor.businessSeeProductsShadowColor().cgColor
    self.layer.shadowOpacity = 0.5;
    self.titleLabel?.font = UIFont.qFontDemiBold(25)
    self.setTitle("SEE PRODUCTS", for: UIControlState())
    self.setTitleColor(UIColor.businessSeeProductsTitleNormalColor(), for: UIControlState())
    self.setTitleColor(UIColor.businessSeeProductsTitleHighlightedColor(), for: .highlighted)
    self.titleLabel?.setKernAmount(2.0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
