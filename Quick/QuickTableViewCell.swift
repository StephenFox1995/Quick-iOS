//
//  QuickTableViewCell.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class QuickTableViewCell: UITableViewCell {
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    self.textLabel?.font = UIFont.qFontRegular(15.0)
    self.clipsToBounds = false
  }
  func setTextElements(_ businessObject: QuickBusinessObject) { }
}
