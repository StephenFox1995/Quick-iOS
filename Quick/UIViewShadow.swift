//
//  UIViewShadow.swift
//  QuickApp
//
//  Created by Stephen Fox on 06/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

protocol UIViewShadow { }

extension UIViewShadow where Self: UIView {
  func addShadow() {
    self.clipsToBounds = false
    self.layer.shadowOffset = CGSize(width: 0, height: 2);
    self.layer.shadowRadius = 1;
    self.layer.shadowColor = UIColor.shadowColor().cgColor
    self.layer.shadowOpacity = 0.5;
  }
}
