//
//  ProductOptionPickerViewDataSource.swift
//  QuickApp
//
//  Created by Stephen Fox on 17/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionPickerViewDataSource: QuickDataSource, UIPickerViewDataSource {
  
  weak var pickerView: ProductOptionPickerView!
  fileprivate var productOption: ProductOption?
  
  /**
   Initialize a new instance with a `UIPickerView`
   - parameter: pickerView: The picker view to datasource.
   */
  init(withPickerView pickerView: ProductOptionPickerView) {
    super.init()
    self.pickerView = pickerView
    self.pickerView.backgroundColor = UIColor.white
    self.pickerView.dataSource = self
  }
  
  
  /**
   Sets the product option to display its values.
   - parameter option: ProductOption to use for datasourcing.
   */
  func setProductOption(option: ProductOption) {
    self.productOption = option
    self.pickerView.reloadAllComponents()
  }
  
  override func itemForRowIndex(_ indexPath: IndexPath) -> AnyObject? {
    if let option = self.productOption {
      return option.values[indexPath.row]
    }
    return nil
  }
  
  // MARK: UIPickerViewDataSource
  @objc(numberOfComponentsInPickerView:) func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if let option = self.productOption {
      return option.values.count
    }
    return 0
  }
  

}
