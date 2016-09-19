//
//  PageControlExtensions.swift
//  QuickApp
//
//  Created by Stephen Fox on 09/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

extension UIPageControl {
  static func changePageIndicator(_ indicator: UIColor, indicatorCurrentPage: UIColor) {
    let pageControl = UIPageControl.appearance()
    pageControl.pageIndicatorTintColor = indicator
    pageControl.currentPageIndicatorTintColor = indicatorCurrentPage
  }
}
