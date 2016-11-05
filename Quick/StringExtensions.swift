//
//  StringExtensions.swift
//  QuickApp
//
//  Created by Stephen Fox on 05/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

extension String {
  static func currencyFormat(amount: Double) -> String {
    return String(format: "%0.2f", amount)
  }
}
