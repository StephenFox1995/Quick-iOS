//
//  ProductOptionPickerViewDataSource.swift
//  QuickApp
//
//  Created by Stephen Fox on 17/10/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class ProductOptionValuesTableViewDataSource: QuickDataSource,
UITableViewDataSource {
  
  weak var tableView: UITableView!
  fileprivate var productOption: ProductOption?
  fileprivate var reuseIdentifier: String!
  var selectedRows: [IndexPath]?
  
  /**
   Initialize a new instance with a `ProductOptionValueTableView`
   - parameter: pickerView: The picker view to datasource.
   */
  init(withTableView tableView: ProductOptionValuesTableView) {
    super.init()
    self.tableView = tableView
    self.tableView.backgroundColor = UIColor.white
    self.tableView.dataSource = self
    self.reuseIdentifier = ProductOptionValuesTableView.cellReuseIdentifier
    self.tableView.register(ProductOptionValuesTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
  }
  
    
  /**
   Sets the product option to display its values.
   - parameter option: ProductOption to use for datasourcing.
   */
  func setProductOption(option: ProductOption) {
    self.productOption = option
    self.tableView.reloadData()
  }
  
  override func itemForRowIndex(_ indexPath: IndexPath) -> AnyObject? {
    if let option = self.productOption {
      return option.values[indexPath.row]
    }
    return nil
  }
  
  
  // MARK: UITableViewDatasource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let values = self.productOption?.values {
      return values.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as!ProductOptionValuesTableViewCell
    let optionValue = self.itemForRowIndex(indexPath) as! ProductOptionValue
    cell.set(productOptionValue: optionValue.detailsWithCurrency(currency: "€"))
    
    // Check to see if the cell should have 'tick'
    if let selectedRows = self.selectedRows {
      if selectedRows.contains(indexPath) {
        cell.accessoryType = .checkmark
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
      } else {
        cell.accessoryType = .none
        self.tableView.deselectRow(at: indexPath, animated: true)
      }
    } else {
      cell.accessoryType = .none
      self.tableView.deselectRow(at: indexPath, animated: true)
    }
    return cell
  }
}
