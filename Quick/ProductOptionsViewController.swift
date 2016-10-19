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
  ProductOptionValuesViewContainerDelegate {
  
  var product: Product!
  
  // ProductOptionsTableView and datasource
  fileprivate var productOptionsTableView: ProductOptionsTableView!
  fileprivate var productOptionsDataSource: ProductOptionsTableViewDataSource!
  
  // `ProductOptionValuesViewContainer`
  fileprivate var productOptionValuesContainer: ProductOptionValuesViewContainer!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fillTableView()
    self.setupViews()
    self.hideNavigationBar = false
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
    self.productOptionValuesContainer = ProductOptionValuesViewContainer(frame: rect)
    self.productOptionValuesContainer.delegate = self
    self.productOptionValuesContainer.isHidden = true // Hide initially.
    self.view.addSubview(self.productOptionValuesContainer)
    
    constrain(self.view, self.productOptionValuesContainer) {
      (superView, pickerView) in
      pickerView.width == superView.width
      pickerView.bottom == superView.bottom
      pickerView.height == superView.height * 0.5
    }
  }
}

// MARK: UITableViewDelegate
extension ProductOptionsViewController {
  @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // When option is selected show pickerView with all the possible values for that option.
    // Firstly get the productOption from the datasource
    let productOption = self.productOptionsDataSource.itemForRowIndex(indexPath) as! ProductOption
    // Then give productOption to pickerView
    self.productOptionValuesContainer.set(productOption: productOption)
    self.productOptionValuesContainer.isHidden = false
  }
}

// MARK: ProductOptionPickerViewContainerDelegate
extension ProductOptionsViewController {
  
  func optionValuesViewContainer(container: ProductOptionValuesViewContainer,
                                 productOption: ProductOption,
                                 didFinishWith values: [ProductOptionValue]?) {
    guard values != nil else {
      return
    }
    
    // Add product and new options
    let productCopy = self.product.copyWithoutOptions()
    productCopy.options = [ProductOption]()
    let option = ProductOption(name: productOption.name, values: values!)
    
    let orderStorage = OrderStorage.sharedInstance
    orderStorage.add(option: option, forProduct: productCopy)
    
    
    self.productOptionValuesContainer.isHidden = true
  }
}
