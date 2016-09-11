//
//  ImageTitleLable.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class BusinessViewImageLabel: UIView {
  
  private var businessNameLabel: UILabel!
  private var businessLocationLabel: UILabel!
  private var businessName: String?
  private var businessLocation: String?

  init(businessName: String, businessLocation: String) {
    super.init(frame: CGRectZero)
    self.businessName = businessName
    self.businessLocation = businessLocation
    self.setupViews()
  }
  
  private func setupViews() {
    self.backgroundColor = UIColor.clearColor()
    self.layer.cornerRadius = 5.0
    self.clipsToBounds = true
  
    self.businessNameLabel = UILabel()
    self.businessNameLabel.font = UIFont.qFontDemiBold(40)
    self.businessNameLabel.minimumScaleFactor = 0.4
    self.businessNameLabel.numberOfLines = 1
    self.businessNameLabel.adjustsFontSizeToFitWidth = true
    self.businessNameLabel.textColor = UIColor.whiteColor()
    self.businessNameLabel.textAlignment = .Left 
    if let bName = self.businessName {
      self.businessNameLabel.text = bName.uppercaseString
    }
    self.addSubview(self.businessNameLabel)
    
    self.businessLocationLabel = UILabel()
    self.businessLocationLabel.font = UIFont.qFontMedium(18)
    self.businessLocationLabel.minimumScaleFactor = 0.4
    self.businessLocationLabel.numberOfLines = 1
    self.businessLocationLabel.adjustsFontSizeToFitWidth = true
    self.businessLocationLabel.textColor = UIColor.whiteColor()
    self.businessLocationLabel.textAlignment = .Left
    self.businessLocationLabel.text = self.businessLocation
    self.businessLocationLabel.setKernAmount(2.0)
    self.addSubview(self.businessLocationLabel)
    
    constrain(self, self.businessNameLabel, self.businessLocationLabel) {
      (superView, businessNameLabel, businessLocationLabel) in
      businessNameLabel.trailing == superView.trailing
      businessNameLabel.width == superView.width * 0.9
      businessNameLabel.bottom == businessLocationLabel.top
      
      businessLocationLabel.trailing == superView.trailing
      businessLocationLabel.width == superView.width * 0.9
      businessLocationLabel.bottom == superView.bottom
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}



