//
//  BusinessInfoStripView.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class BusinessInfoStripView: StripView {
  
  fileprivate var businessHoursView: BusinessHoursView!
  var businessStatusView: BusinessStatusView!
  fileprivate var favouriteButton: FavouriteButton!
  
  
  override init() {
    super.init()
    self.addSeparators()
    
    self.businessHoursView = BusinessHoursView(availability: .open)
    self.businessStatusView = BusinessStatusView(status: "...")
    self.favouriteButton = FavouriteButton()
    self.addSubview(self.businessHoursView)
    self.addSubview(self.businessStatusView)
    self.addSubview(self.favouriteButton)
    
    constrain(self, self.businessHoursView, self.businessStatusView, self.favouriteButton) {
      (superView, businessHoursView, businessWaitingTimeView, favouriteButton) in
      businessHoursView.width == superView.width * 0.15
      businessHoursView.height == superView.height * 0.8
      businessHoursView.top == superView.top + 5
      businessHoursView.leading == superView.leading + 10
      
      businessWaitingTimeView.width == superView.width * 0.40
      businessWaitingTimeView.height == superView.height * 0.8
      businessWaitingTimeView.center == superView.center
      
      favouriteButton.width == superView.width * 0.25
      favouriteButton.height == superView.height * 0.8
      favouriteButton.top == superView.top + 5
      favouriteButton.trailing == superView.trailing - 10
    }
  }
  
  fileprivate func addSeparators() {
    let sepOne = UIView()
    sepOne.layer.cornerRadius = 3
    sepOne.backgroundColor = UIColor.businessInfoStripSeparatorColor()
    self.addSubview(sepOne)
    self.bringSubview(toFront: sepOne)
    
    let sepTwo = UIView()
    sepTwo.layer.cornerRadius = 3
    sepTwo.backgroundColor = UIColor.businessInfoStripSeparatorColor()
    self.addSubview(sepTwo)
    self.bringSubview(toFront: sepTwo)
    
    constrain(self, sepOne, sepTwo) {
      (superView, sepOne, sepTwo) in
      sepOne.trailing == superView.trailing * 0.25
      sepOne.width == 2
      sepOne.height == superView.height * 0.5
      sepOne.centerY == superView.centerY
      
      sepTwo.trailing == superView.trailing * 0.75
      sepTwo.width == 2
      sepTwo.height == superView.height * 0.5
      sepTwo.centerY == superView.centerY
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
