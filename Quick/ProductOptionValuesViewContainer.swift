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
                                 productOption: ProductOption,
                                 didFinishWith values: [ProductOptionValue]?)
}


/**
 This class manages a pickerView and buttons that
 interact with the view.
 */
class ProductOptionValuesViewContainer: UIView,
UITableViewDelegate,
UIViewShadow {
  
  fileprivate var tableView: ProductOptionValuesTableView!
  fileprivate var doneButton: QButton!
  fileprivate var currentProductOptionDisplayed: ProductOption!
  weak var delegate: ProductOptionValuesViewContainerDelegate?
  fileprivate var datasource: ProductOptionValuesTableViewDataSource!
  // Keep reference to the selected rows for each value of the current product option.
  fileprivate var selectedRowsForOption: [String: [IndexPath]] = [:]
  // Flag if a row was selected or deseleted.
  var rowWasHit = false
  
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
   @parameter productOption: ProductOption who's [ProductValue] to display in the tableview.
   */
  func set(productOption: ProductOption) {
    self.datasource.setProductOption(option: productOption)
    self.currentProductOptionDisplayed = productOption // Keep reference so we can pass to delegate.
    self.datasource.selectedRows = self.selectedRowsForOption[productOption.name]
    self.rowWasHit = false
  }
  
  /// Adds row to all selected rows for this product option
  fileprivate func addRowForCurrentProductOption(row: IndexPath) {
    if self.selectedRowsForOption[self.currentProductOptionDisplayed.name] == nil {
      self.selectedRowsForOption[self.currentProductOptionDisplayed.name] = []
    }
    self.selectedRowsForOption[self.currentProductOptionDisplayed.name]!.append(row)
  }
  
  /// Removes a row from the selected rows.
  fileprivate func removeRowForCurrentProductOptions(row: IndexPath) {
    if self.selectedRowsForOption[self.currentProductOptionDisplayed.name] == nil {
      return
    }
    let index = self.selectedRowsForOption[self.currentProductOptionDisplayed.name]!.index(of: row)
    if let i = index {
      self.selectedRowsForOption[self.currentProductOptionDisplayed.name]!.remove(at: i)
    }
  }

  fileprivate func setupViews() {
    self.addShadow()
    self.backgroundColor = UIColor.quickGray()
    
    let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
    self.tableView = ProductOptionValuesTableView(frame: rect, style: .plain)
    self.tableView.delegate = self
    self.tableView.dataSource = self.datasource
    // TODO: Make sure to check if the product offers multiple selections.
    self.tableView.allowsMultipleSelection = true
    self.addSubview(self.tableView)
    self.datasource = ProductOptionValuesTableViewDataSource(withTableView: self.tableView)
    
    self.doneButton = QButton()
    self.doneButton.addTarget(self, action: #selector(ProductOptionValuesViewContainer.handleDoneButtonPress), for: .touchUpInside)
    self.doneButton.setTitle("Done", for: .normal)
    self.doneButton.setTitleColor(UIColor.quickBlue(), for: .normal)
    self.addSubview(self.doneButton)
    
    constrain(self, self.tableView, self.doneButton) {
      (superView, tableView, doneButton) in
      doneButton.width == superView.width * 0.3
      doneButton.height == superView.height * 0.2
      doneButton.top == superView.top
      
      tableView.width == superView.width
      tableView.height == superView.height * 0.8
      tableView.top == doneButton.bottom
      tableView.bottom == superView.bottom
    }
  }
  
  @objc fileprivate func handleDoneButtonPress() {
    // Message delegate that user has finished selected options.
    if let lDelegate = self.delegate {
      // Get all selected values from tableView.
      let selectedRows: [IndexPath]? = self.selectedRowsForOption[self.currentProductOptionDisplayed.name]
      
      // Build array with all the values, if there are any.
      if let rows = selectedRows {
        var productOptionValues = [ProductOptionValue]()
        for row in rows {
          productOptionValues.append(self.datasource.itemForRowIndex(row) as! ProductOptionValue)
        }
        return lDelegate.optionValuesViewContainer(container: self,
                                                   productOption: self.currentProductOptionDisplayed,
                                                   didFinishWith: productOptionValues)
      }
      lDelegate.optionValuesViewContainer(container: self,
                                          productOption: self.currentProductOptionDisplayed,
                                          didFinishWith: nil)
    }
  }
}

// MARK: UITableViewDelegate
extension ProductOptionValuesViewContainer {
  @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: If an option can only have one value selected this is maybe where that should be checked??
    self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    self.addRowForCurrentProductOption(row: indexPath)
  }
  
  @objc(tableView:didDeselectRowAtIndexPath:) func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
    self.rowWasHit = true
    self.removeRowForCurrentProductOptions(row: indexPath)
  }
}

