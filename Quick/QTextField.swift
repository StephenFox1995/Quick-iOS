//
//  QTextField.swift
//  QuickLoginViewController
//
//  Created by Stephen Fox on 06/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import FontAwesome_swift

class QTextField: UIView, UITextFieldDelegate {
  
  private var icon: UILabel?
  var field: UITextField?
  
  private let leadingPadding: CGFloat = 20.0
  
  
  init(frame: CGRect, fontAwesome: String) {
    super.init(frame: frame)
    self.layer.cornerRadius = 25.0
    self.layer.borderWidth = 0.0
    self.backgroundColor = UIColor.whiteColor()
    self.layer.borderColor = UIColor.qTextFieldGrayColor().CGColor
  
    // Add Icon
    self.icon = UILabel(frame: CGRectMake(self.leadingPadding, 10, 25, 25))
    self.icon?.textColor = UIColor.qTextFieldGrayColor()
    self.icon?.font = UIFont.fontAwesomeOfSize(20)
    self.icon?.text = fontAwesome
    self.addSubview(self.icon!)
    
    // Add TextField
    self.field = UITextField(frame: CGRectMake(self.leadingPadding + 50, 5, self.frame.size.width - 50 - self.leadingPadding , 40))
    self.field?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    self.field?.delegate = self
    self.field?.textColor = UIColor.qTextFieldGrayColor()
    self.addSubview(self.field!)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: UITextFieldDelegate
  func textFieldDidBeginEditing(textField: UITextField) {
    let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 25.0)
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.qTextFieldBlueColor().CGColor
    self.layer.shadowOffset = CGSizeMake(0.0, 3.0)
    self.layer.shadowOpacity = 0.5
    self.layer.shadowPath = shadowPath.CGPath
  }

  func textFieldDidEndEditing(textField: UITextField) {
    self.layer.shadowOpacity = 0.0
  }
}
