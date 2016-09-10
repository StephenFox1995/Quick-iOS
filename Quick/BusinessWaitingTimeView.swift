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

class BusinessWaitingTimeView: UIView {
  private var timeLabel: UILabel!
  private var averageTimeLabel = UILabel()
  private var timeIcon = UILabel()
  private var time: Int!
  
  init(minutes: Int) {
    super.init(frame: CGRectZero)
    self.time = minutes
    self.setupViews()
  }
  
  
  private func setupViews() {
    self.timeLabel = UILabel()
    self.timeLabel.font = UIFont.qFontDemiBold(25)
    self.timeLabel.textColor = UIColor.businessWaitingTimeViewGrayColor()
    self.timeLabel.minimumScaleFactor = 0.5
    self.timeLabel.numberOfLines = 1
    self.timeLabel.adjustsFontSizeToFitWidth = true
    self.timeLabel.text = String(self.time)
    self.addSubview(self.timeLabel)
    
    self.timeIcon.font = UIFont.fontAwesomeOfSize(18)
    self.timeIcon.text = String.fontAwesomeIconWithCode("fa-clock-o")
    self.timeIcon.textColor = UIColor.businessWaitingTimeViewGrayColor()
    self.addSubview(self.timeIcon)
    
    self.averageTimeLabel.text = "AVERAGE TIME (MINS)"
    self.averageTimeLabel.font = UIFont.qFontRegular(13)
    self.averageTimeLabel.textColor = UIColor.businessWaitingTimeViewGrayColor()
    self.averageTimeLabel.minimumScaleFactor = 0.5
    self.averageTimeLabel.numberOfLines = 1
    self.averageTimeLabel.adjustsFontSizeToFitWidth = true
    self.addSubview(self.averageTimeLabel)
    
    constrain(self, self.timeLabel, self.timeIcon, self.averageTimeLabel) {
      (superView, timeLabel, timeIcon, averageTimeLabel) in
      timeIcon.trailing == timeLabel.leading - 3
      timeIcon.top == superView.top
      timeIcon.bottom == averageTimeLabel.top
      
      timeLabel.centerX == superView.centerX
      timeLabel.bottom == averageTimeLabel.top
      timeLabel.top == superView.top
      
      averageTimeLabel.bottom == superView.bottom
      averageTimeLabel.centerX == superView.centerX
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
