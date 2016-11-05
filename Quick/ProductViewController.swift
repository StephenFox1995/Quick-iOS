//
//  PViewController.swift
//  QuickApp
//
//  Created by Stephen Fox on 10/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography
import SwiftyJSON

/**
 Class that display info about a Product and allows a user to order the Product
 */
class ProductViewController: QuickViewController,
ProductOptionValuesViewContainerDelegate,
UITableViewDelegate {
  
  /// Product property, this needs to be set for the view to load product info
  var product: Product!
  var business: Business?
  var optionsChosen : [ProductOption]?
  
  
  fileprivate var productPricingStripView: ProductPricingStripView!
  fileprivate var addToOrderButton = QButton()
  fileprivate var network = Network()
  fileprivate var productOptionsTableView: ProductOptionsTableView!
  fileprivate var productOptionsDataSource: ProductOptionsTableViewDataSource!
  fileprivate var productOptionValuesContainer: ProductOptionValuesViewContainer!
  fileprivate var shadowDropBack: ShadowDropBack!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isTranslucent = false
    self.view.backgroundColor = UIColor.viewControllerBackgroundGray()
    
    self.setupViews()
  }
  
  fileprivate func setupViews() {
    self.shadowDropBack = ShadowDropBack(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
    self.view.addSubview(self.shadowDropBack)
    self.shadowDropBack.isHidden = true
    
    self.productPricingStripView = ProductPricingStripView(product: self.product!)
    self.view.addSubview(self.productPricingStripView)
    
    // If the product has options to choose from display the tableview.
    if let options = self.product.options {
      self.productOptionsTableView = ProductOptionsTableView()
      self.productOptionsTableView.delegate = self
      self.productOptionsDataSource = ProductOptionsTableViewDataSource(tableView: self.productOptionsTableView)
      self.productOptionsDataSource.setProductOptions(productOptions: options)
      self.view.addSubview(self.productOptionsTableView)
      
      self.productOptionValuesContainer = ProductOptionValuesViewContainer()
      self.productOptionValuesContainer.delegate = self
      self.productOptionValuesContainer.isHidden = true
      self.view.addSubview(self.productOptionValuesContainer)
    }
    
    self.addToOrderButton.setTitle("ADD TO ORDER", for: UIControlState())
    self.addToOrderButton.titleLabel?.setKernAmount(2.0)
    self.addToOrderButton.addTarget(self, action: #selector(ProductViewController.addProductToOrder), for: .touchUpInside)
    self.addToOrderButton.layer.cornerRadius = 0
    self.view.addSubview(self.addToOrderButton)
    
    
    constrain(self.view, self.productPricingStripView, self.productOptionsTableView, self.addToOrderButton, self.productOptionValuesContainer) {
      (superView, pricingView, optionsTableView, addToOrderButton, optionValuesContainer) in
      pricingView.leading == superView.leading
      pricingView.width == superView.width
      pricingView.top == superView.top
      pricingView.height == superView.height * 0.2
      
      addToOrderButton.bottom == superView.bottom
      addToOrderButton.leading == superView.leading
      addToOrderButton.trailing == superView.trailing
      addToOrderButton.height == superView.height * 0.1
      
      optionsTableView.leading == superView.leading
      optionsTableView.top == pricingView.bottom + 10
      optionsTableView.bottom == addToOrderButton.top - 10
      optionsTableView.width == superView.width
      optionsTableView.trailing == superView.trailing
      
      optionValuesContainer.bottom == superView.bottom
      optionValuesContainer.left == superView.left
      optionValuesContainer.width == superView.width
      optionValuesContainer.height == superView.height * 0.5
    }
  }
  
  
  // Addds product to global order storage.
  @objc fileprivate func addProductToOrder() {
    let product = self.product.copyWithoutOptions()
    if let options = self.optionsChosen {
      product.options = options
      // Update the order price with the new options chosen.
      product.updateOrderPrice(options: options)
    }
    
    OrderManager.sharedInstance.addToOrder(product: product)
    self.orderAddedMessage()
  }
  
  // Order error alert.
  fileprivate func orderAddedMessage() {
    self.displayMessage(title: StringConstants.orderAddedTitleString,
                        message: StringConstants.orderAddedMessageString)
  }
}



// MARK: UITableViewDelegate
extension ProductViewController {
  @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // When option is selected show view with all the possible values for that option.
    // Firstly get the productOption from the datasource
    let productOption = self.productOptionsDataSource.itemForRowIndex(indexPath) as! ProductOption
    // Then give productOption to view
    self.productOptionValuesContainer.set(productOption: productOption)
    self.productOptionValuesContainer.isHidden = false
    self.shadowDropBack.isHidden = false
    self.view.bringSubview(toFront: self.shadowDropBack)
    self.view.bringSubview(toFront: self.productOptionValuesContainer)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UILabel(frame: CGRect(x: 0, y: 10, width: 55, height: 55))
    header.textColor = UIColor.black
    header.font = UIFont.qFontDemiBold(14)
    header.setKernAmount(2.0)
    header.text = "OPTIONS"
    return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 55.0
  }
}

// MARK: ProductOptionPickerViewContainerDelegate
extension ProductViewController {
  func optionValuesViewContainer(container: ProductOptionValuesViewContainer,
                                 productOption: ProductOption,
                                 didFinishWith values: [ProductOptionValue]?) {
    self.productOptionValuesContainer.isHidden = true
    self.shadowDropBack.isHidden = true
    guard values != nil else {
      return
    }
    
    // Add product and new options
    let option = ProductOption(name: productOption.name, values: values!)
    if self.optionsChosen == nil {
      self.optionsChosen = []
    }
    self.optionsChosen!.append(option)
    
  }
}

