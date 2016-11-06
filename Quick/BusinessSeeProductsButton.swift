//
//  BusinessSeeProductsView.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 09/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class BusinessSeeProductsButton: UIButton, UIViewShadow {

  init() {
    super.init(frame: CGRect.zero)
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    self.addShadow()
    self.backgroundColor = UIColor.white
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
