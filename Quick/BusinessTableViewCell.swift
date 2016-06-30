//
//  BusinessTableViewCell.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
  
  @IBOutlet weak var businessName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func businessDetails(business: Business) {
    self.businessName.text = business.name
  }
}
