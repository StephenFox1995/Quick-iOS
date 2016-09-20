//
//  QTextField.swift
//  QuickLoginViewController
//
//  Created by Stephen Fox on 06/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Cartography

class QTextField: UIView, UITextFieldDelegate {
  
  fileprivate var icon: UILabel!
  fileprivate var fontAwesomeString: String?
  /// TextField property of the view
  var field: UITextField!
  
  
  init(fontAwesome: String) {
    super.init(frame: CGRect.zero)
    self.fontAwesomeString = fontAwesome
    self.setupViews()
  }
  
  
  fileprivate func setupViews() {
    self.layer.cornerRadius = 25.0
    self.layer.borderWidth = 0.0
    self.backgroundColor = UIColor.white
    self.layer.borderColor = UIColor.qTextFieldGrayColor().cgColor
    
    // Add Icon
    self.icon = UILabel()
    self.icon?.textColor = UIColor.qTextFieldGrayColor()
    self.icon?.font = UIFont.fontAwesomeOfSize(20)
    self.icon?.text = self.fontAwesomeString
    self.addSubview(self.icon!)
    
    // Add TextField
    self.field = UITextField()
    self.field?.font = UIFont.qFontDemiBold(16)
    self.field?.delegate = self
    self.field?.textColor = UIColor.qTextFieldGrayColor()
    self.addSubview(self.field!)
    
    constrain(self, self.icon, self.field) {
      (superView, icon, field) in
      let padding: CGFloat = 20.0
      
      icon.leading == superView.leading + padding
      icon.top == superView.top + 10
      icon.width == 25
      icon.height == 25
      
      field.leading == superView.leading + 50 + padding
      field.top == superView.top + 5
      field.width == superView.width - 70
      field.height == superView.height * 0.7
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: UITextFieldDelegate
  func textFieldDidBeginEditing(_ textField: UITextField) {
    let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 25.0)
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.qTextFieldBlueColor().cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    self.layer.shadowOpacity = 0.5
    self.layer.shadowPath = shadowPath.cgPath
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    self.layer.shadowOpacity = 0.0
  }
}
