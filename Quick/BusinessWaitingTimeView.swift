//
//  BusinessWaitingTimeView.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 08/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Cartography

class BusinessStatusView: UIView {
  fileprivate var statusLabel: UILabel!
  fileprivate var averageTimeLabel = UILabel()
  fileprivate var timeIcon = UILabel()
  fileprivate var status: String!
  
  init(status: String) {
    super.init(frame: CGRect.zero)
    self.status = status
    self.setupViews()
  }
  
  
  func setStatus(status: String) {
    self.statusLabel.text = status
  }
  
  
  fileprivate func setupViews() {
    self.statusLabel = UILabel()
    self.statusLabel.font = UIFont.qFontDemiBold(13)
    self.statusLabel.textColor = UIColor.businessWaitingTimeViewGrayColor()
    self.statusLabel.minimumScaleFactor = 0.5
    self.statusLabel.numberOfLines = 1
    self.statusLabel.adjustsFontSizeToFitWidth = true
    self.statusLabel.text = self.status
    self.addSubview(self.statusLabel)
    
    self.timeIcon.font = UIFont.fontAwesomeOfSize(18)
    self.timeIcon.text = String.fontAwesomeIconWithCode("fa-clock-o")
    self.timeIcon.textColor = UIColor.businessWaitingTimeViewGrayColor()
    self.addSubview(self.timeIcon)
    
    self.averageTimeLabel.text = "Status"
    self.averageTimeLabel.font = UIFont.qFontRegular(13)
    self.averageTimeLabel.textColor = UIColor.businessWaitingTimeViewGrayColor()
    self.averageTimeLabel.minimumScaleFactor = 0.5
    self.averageTimeLabel.numberOfLines = 1
    self.averageTimeLabel.adjustsFontSizeToFitWidth = true
    self.addSubview(self.averageTimeLabel)
    
    constrain(self, self.statusLabel, self.timeIcon, self.averageTimeLabel) {
      (superView, statusLabel, timeIcon, averageTimeLabel) in
      timeIcon.trailing == statusLabel.leading - 3
      timeIcon.top == superView.top
      timeIcon.bottom == averageTimeLabel.top
      
      statusLabel.centerX == superView.centerX
      statusLabel.bottom == averageTimeLabel.top
      statusLabel.top == superView.top
      
      averageTimeLabel.bottom == superView.bottom
      averageTimeLabel.centerX == superView.centerX
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
