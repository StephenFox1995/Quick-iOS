//
//  FXPrint.swift
//  Quick
//
//  Created by Stephen Fox on 06/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 Use this function to print output to the console
 only when the app's in development enviroment.
 */
func fxprint(_ content: String) {
  if AppDelegate.devEnvironment {
    print(content)
  }
}
