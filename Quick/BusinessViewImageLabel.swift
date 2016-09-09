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
  
  
  struct ImageTitleFont {
    static let nameFont = UIFont(name: "AvenirNext-DemiBold", size: 25.0)
    static let locationFont = UIFont(name: "AvenirNext-Medium", size: 14.0)
  }
  
  init(businessName: String, businessLocation: String) {
    super.init(frame: CGRectZero)
    self.backgroundColor = UIColor.clearColor()
    self.layer.cornerRadius = 5.0
    self.clipsToBounds = true
    
    self.businessNameLabel = UILabel()
    self.businessNameLabel.font = ImageTitleFont.nameFont
    self.businessNameLabel.minimumScaleFactor = 0.4
    self.businessNameLabel.numberOfLines = 1
    self.businessNameLabel.adjustsFontSizeToFitWidth = true
    self.businessNameLabel.textColor = UIColor.whiteColor()
    self.businessNameLabel.textAlignment = .Left
    self.businessNameLabel.text = businessName
    self.addSubview(self.businessNameLabel)
    
    self.businessLocationLabel = UILabel()
    self.businessLocationLabel.font = ImageTitleFont.locationFont
    self.businessLocationLabel.minimumScaleFactor = 0.4
    self.businessLocationLabel.numberOfLines = 1
    self.businessLocationLabel.adjustsFontSizeToFitWidth = true
    self.businessLocationLabel.textColor = UIColor.whiteColor()
    self.businessNameLabel.textAlignment = .Left
    self.businessLocationLabel.text = businessLocation
    self.businessLocationLabel.setKernAmount(2.0)
    self.addSubview(self.businessLocationLabel)
    
    constrain(self, self.businessNameLabel, self.businessLocationLabel) {
      (superView, businessNameLabel, businessLocationLabel) in
      businessNameLabel.trailing == superView.trailing
      businessNameLabel.top == superView.top + 5
      businessNameLabel.width == superView.width * 0.9
      businessNameLabel.height == superView.height * 0.4
      
      businessLocationLabel.trailing == superView.trailing
      businessLocationLabel.top == businessNameLabel.bottom
      businessLocationLabel.width == superView.width * 0.9
      businessLocationLabel.height == superView.height * 0.2
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


extension UILabel {
  func setKernAmount(kernAmount: CGFloat) {
    var labelFont: UIFont!
    if let font = self.font {
      labelFont = font
    } else {
      labelFont = UIFont(name: "HelveticaNeue-Light", size: 20)!
    }
    var labelText: String!
    if let text = self.text {
      labelText = text
    } else {
      labelText = ""
    }
    
    let attributes: NSDictionary = [
      NSFontAttributeName:labelFont,
      NSForegroundColorAttributeName:UIColor.whiteColor(),
      NSKernAttributeName:CGFloat(kernAmount)
    ]
    let attributedText = NSAttributedString(string: labelText, attributes: attributes as? [String : AnyObject])
    self.attributedText = attributedText
    self.sizeToFit()
  }
}
