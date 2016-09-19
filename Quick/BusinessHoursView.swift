//
//  BusinessHoursView.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class BusinessHoursView: UIView {
  
  fileprivate var hoursLabel: UILabel!
  enum BusinessHours {
    case open, closed
  }

  
  init(availability: BusinessHours) {
    super.init(frame: CGRect.zero)
    self.layer.cornerRadius = 20.0
    self.hoursLabel = UILabel()
    self.hoursLabel.textColor = UIColor.white
    self.hoursLabel.textAlignment = .center
    self.hoursLabel.font = UIFont.qFontDemiBold(14)
    self.hoursLabel.minimumScaleFactor = 0.5
    self.hoursLabel.numberOfLines = 1
    self.hoursLabel.adjustsFontSizeToFitWidth = true
    self.addSubview(self.hoursLabel)
    
    constrain(self, self.hoursLabel) {
      (superView, hoursLabel) in
      hoursLabel.top == superView.top
      hoursLabel.bottom == superView.bottom
      hoursLabel.size == superView.size
      hoursLabel.leading == superView.leading
    }
    
    switch availability {
    case .open:
      self.hoursLabel.text = "OPEN"
      self.backgroundColor = UIColor.businessHoursViewGreen()
    case .closed:
      self.hoursLabel.text = "CLOSED"
      self.backgroundColor = UIColor.businessHoursViewRed()
    }
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
