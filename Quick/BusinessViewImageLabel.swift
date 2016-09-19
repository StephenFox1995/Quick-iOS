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
  
  fileprivate var businessNameLabel: UILabel!
  fileprivate var businessLocationLabel: UILabel!
  fileprivate var businessName: String?
  fileprivate var businessLocation: String?

  init(businessName: String, businessLocation: String) {
    super.init(frame: CGRect.zero)
    self.businessName = businessName
    self.businessLocation = businessLocation
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    self.backgroundColor = UIColor.clear
    self.layer.cornerRadius = 5.0
    self.clipsToBounds = true
  
    self.businessNameLabel = UILabel()
    self.businessNameLabel.font = UIFont.qFontDemiBold(40)
    self.businessNameLabel.minimumScaleFactor = 0.4
    self.businessNameLabel.numberOfLines = 1
    self.businessNameLabel.adjustsFontSizeToFitWidth = true
    self.businessNameLabel.textColor = UIColor.white
    self.businessNameLabel.textAlignment = .left 
    if let bName = self.businessName {
      self.businessNameLabel.text = bName.uppercased()
    }
    self.addSubview(self.businessNameLabel)
    
    self.businessLocationLabel = UILabel()
    self.businessLocationLabel.font = UIFont.qFontMedium(18)
    self.businessLocationLabel.minimumScaleFactor = 0.4
    self.businessLocationLabel.numberOfLines = 1
    self.businessLocationLabel.adjustsFontSizeToFitWidth = true
    self.businessLocationLabel.textColor = UIColor.white
    self.businessLocationLabel.textAlignment = .left
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



