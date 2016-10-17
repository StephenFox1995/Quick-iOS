//
//  ProductOptionsViewController.swift
//  QuickApp
//
//  Created by Stephen Fox on 16/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class ProductOptionsViewController: QuickViewController,
  UITableViewDelegate,
  UIPickerViewDelegate {
  
  var product: Product!
  // ProductOptionsTableView and datasource
  fileprivate var productOptionsTableView: ProductOptionsTableView!
  fileprivate var productOptionsDataSource: ProductOptionsTableViewDataSource!
  // ProductOption and datasource
  fileprivate var productOptionPickerView: ProductOptionPickerView!
  fileprivate var productOptionPickerViewDataSource: ProductOptionPickerViewDataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fillTableView()
    self.setupViews()
  }
  
  
  
  fileprivate func fillTableView() {
    if self.productOptionsDataSource == nil {
      // Setup tableview.
      let rect = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
      self.productOptionsTableView = ProductOptionsTableView(frame: rect, style: .plain)
      self.productOptionsTableView.delegate = self
      
      // Set datasource.
      self.productOptionsDataSource = ProductOptionsTableViewDataSource(tableView: self.productOptionsTableView)
      self.productOptionsDataSource.setProductOptions(productOptions: self.product.options!)
      self.view.addSubview(self.productOptionsTableView)
    }
  }
  
  fileprivate func setupViews() {
    // Setup pickerView
    let rect = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height / 2)
    self.productOptionPickerView = ProductOptionPickerView(frame: rect)
    self.productOptionPickerView.delegate = self
    self.productOptionPickerViewDataSource =
      ProductOptionPickerViewDataSource(withPickerView: self.productOptionPickerView)
    self.view.addSubview(self.productOptionPickerView)
    
    constrain(self.view, self.productOptionPickerView) {
      (superView, pickerView) in
      pickerView.width == superView.width
      pickerView.bottom == superView.bottom
      pickerView.height == superView.height * 0.3
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

// MARK: UITableViewDelegate
extension ProductOptionsViewController {
  @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // When option is selected show pickerView with all the possible values for that option.
    // Firstly get the productOption from the datasource
    let productOption = self.productOptionsDataSource.itemForRowIndex(indexPath) as! ProductOption
    // Then give productOption to pickerView
    self.productOptionPickerViewDataSource.setProductOption(option: productOption)
  }
}


// MARK: UIPickerViewDelegate
extension ProductOptionsViewController {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let indexPath = IndexPath(row: row, section: 0)
    let optionValue = self.productOptionPickerViewDataSource.itemForRowIndex(indexPath) as! ProductOptionValue
    return optionValue.name
  }
}
