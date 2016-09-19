//
//  BusinessTableViewCell.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class BusinessTableViewCell: QuickTableViewCell {
  
  @IBOutlet weak var businessName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  override func setTextElements(_ businessObject: QuickBusinessObject) {
    self.businessName.text = businessObject.name
  }
}
