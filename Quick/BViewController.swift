//
//  ViewController.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

class BViewController: QuickViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.businessViewControllerBackgroundGray()
    self.setupViews()
    self.translucentNavigationBar = true
  }
  
  
  // Sets up the UI
  private func setupViews() {
    let businessImageView = BusinessImageView(businessName: "STARBUCKS COFFEE", businessLocation: "KEVIN SQUARE")
    self.view.addSubview(businessImageView)
    
    dispatch_async(dispatch_get_global_queue(0, 0)) {
      let url = NSURL(string: "https://cdn-starbucks.netdna-ssl.com/uploads/images/_framed/d9N8OfXy-4928-3264.jpg")
      let nsdata = NSData.init(contentsOfURL: url!)
      dispatch_async(dispatch_get_main_queue(), {
        let uiImage = UIImage(data: nsdata!)
        businessImageView.image = uiImage
        
      })
    }
    
    let stripView = BusinessInfoStripView()
    self.view.addSubview(stripView)
    
    let seeProductsButton = BusinessSeeProductsButton()
    self.view.addSubview(seeProductsButton)
    
    constrain(self.view, stripView, businessImageView, seeProductsButton) {
      (superView, stripView, businessImageView, seeProductsView) in
      
      businessImageView.leading == superView.leading
      businessImageView.trailing == superView.trailing
      businessImageView.top == superView.topMargin
      businessImageView.height == superView.height * 0.4
      
      stripView.width == superView.width
      stripView.height == superView.height * 0.1
      stripView.top == businessImageView.bottom
      stripView.leading == superView.leading
      
      seeProductsView.width == superView.width
      seeProductsView.height == superView.height * 0.1
      seeProductsView.leading == superView.leading
      seeProductsView.trailing == superView.trailing
      seeProductsView.top == stripView.bottom + 10
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}



