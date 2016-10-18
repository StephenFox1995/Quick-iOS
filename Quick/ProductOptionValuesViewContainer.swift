//
//  ProductOptionPickerViewContainer.swift
//  QuickApp
//
//  Created by Stephen Fox on 18/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

protocol ProductOptionValuesViewContainerDelegate: NSObjectProtocol {
  func optionValuesViewContainer(container: ProductOptionValuesViewContainer,
                                 didFinishWith values: [ProductOptionValue]?)
  
  func optionValuesViewContainer(container: ProductOptionValuesViewContainer,
                                 productOption: ProductOption,
                                 didSelectNewValue value: ProductOptionValue)
}


/**
 This class manages a pickerView and buttons that
 interact with the view.
 */
class ProductOptionValuesViewContainer: UIView,
UITableViewDelegate {
  
  fileprivate var tableView: ProductOptionValuesTableView!
  fileprivate var doneButton: UIButton!
  fileprivate var currentProductOptionDisplayed: ProductOption!
  
  weak var delegate: ProductOptionValuesViewContainerDelegate?
  fileprivate var datasource: ProductOptionValuesTableViewDataSource!
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupViews()
  }
  
  /**
   Sets the product options whose values will be show by the picker view.
   @parameter productOption: ProductOption who's [ProductValue] to display in the pickerView.
   */
  func set(productOption: ProductOption) {
    self.datasource.setProductOption(option: productOption)
    self.currentProductOptionDisplayed = productOption // Keep reference so we can pass to delegate.
  }
  

  func setupViews() {
    self.backgroundColor = UIColor.white
    
    let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
    self.tableView = ProductOptionValuesTableView(frame: rect, style: .plain)
    self.tableView.delegate = self
    self.tableView.dataSource = self.datasource
    self.addSubview(self.tableView)
    self.datasource = ProductOptionValuesTableViewDataSource(withTableView: self.tableView)
    
    self.doneButton = UIButton()
    self.doneButton.addTarget(self, action: #selector(ProductOptionValuesViewContainer.handleDoneButtonPress), for: .touchUpInside)
    self.doneButton.setTitle("Done", for: .normal)
    self.doneButton.setTitleColor(UIColor.quickBlue(), for: .normal)
    self.addSubview(self.doneButton)
    
    constrain(self, self.tableView, self.doneButton) {
      (superView, tableView, doneButton) in
      doneButton.width == superView.width * 0.3
      doneButton.height == superView.height * 0.1
      doneButton.top == superView.top
      
      tableView.width == superView.width
      tableView.height == superView.height * 0.9
      tableView.top == doneButton.bottom
      tableView.bottom == superView.bottom
    }
  }
  
  @objc fileprivate func handleDoneButtonPress() {
    // Message delegate.
    if let lDelegate = self.delegate {
      lDelegate.optionValuesViewContainer(container: self, didFinishWith: nil)
    }
  }
}

// MARK: UITableViewDelegate
extension ProductOptionValuesViewContainer {
  @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Message delegate
    if let lDelegate = self.delegate  {
      // Get the value
      let optionValue = self.datasource.itemForRowIndex(indexPath) as! ProductOptionValue
      // Get the productOption.
      lDelegate.optionValuesViewContainer(container: self,
                                          productOption: self.currentProductOptionDisplayed,
                                          didSelectNewValue: optionValue)
    }
  }
}

