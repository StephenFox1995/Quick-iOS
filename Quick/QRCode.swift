//
//  QRCode.swift
//  Quick
//
//  Created by Stephen Fox on 17/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

class QRCode {
  static func generateFromString(_ string: String) -> UIImage {
    // Source: https://github.com/ShinobiControls/iOS7-day-by-day/blob/master/15-core-image-filters/15-core-image-filters.md
    // Convert to UTF-8 encoded NSData object
    let stringData = string.data(using: String.Encoding.utf8)
    
    // Create filter
    let qrFilter: CIFilter = CIFilter(name: "CIQRCodeGenerator")!
    qrFilter.setValue(stringData, forKey: "inputMessage")
    qrFilter.setValue("H", forKey: "inputCorrectionLevel")
    
    // Return image.
    return UIImage(ciImage: qrFilter.outputImage!)
  }
}
