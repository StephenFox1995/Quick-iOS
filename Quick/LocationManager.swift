//
//  LocationManager.swift
//  QuickApp
//
//  Created by Stephen Fox on 26/11/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
  
  fileprivate var coreLocationManager: CLLocationManager!
  fileprivate var userCoordinate: CLLocationCoordinate2D?
  fileprivate var locationCallback: UserLocationCallback?
  typealias UserLocationCallback = ((_ coordinates: CLLocationCoordinate2D, _ error: LocationError?) -> Void)

  enum LocationError: Error {
    case PermissionDenied
  }
  
  override init() {
    super.init()
    self.coreLocationManager = CLLocationManager()
    self.coreLocationManager.delegate = self
    self.coreLocationManager.desiredAccuracy = CLLocationAccuracy()
    self.coreLocationManager.distanceFilter = CLLocationDistance()
  }
  
  
  /**
   Attempts to get the current location of the user if permission allow.
   - parameter callback: Callback with coordinates if successful and no error.
                         If unsuccessful kCLLocationCoordinate2DInvalid with error set.
   */
  func getCurrentLocation(callback: @escaping UserLocationCallback) {
    self.locationCallback = callback
    do {
      try self.locate()
    } catch {
      self.locationCallback!(kCLLocationCoordinate2DInvalid, LocationError.PermissionDenied)
      self.locationCallback = nil
    }
  }
  
  /// Call when, permissions for location are known.
  fileprivate func findUserLocation() {
    self.coreLocationManager.startUpdatingLocation()
  }
  
  
  /// Attempts to locate user, if cannot due to permissions then error is thrown
  fileprivate func locate() throws {
    if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined:
        self.coreLocationManager.requestWhenInUseAuthorization()
      case .authorizedWhenInUse:
        self.findUserLocation()
      default:
        throw LocationError.PermissionDenied
      }
    } else {
      throw LocationError.PermissionDenied
    }
  }
}

// MARK: CLLocationManagerDelegate
extension Location {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      if let cb = self.locationCallback {
        self.coreLocationManager.stopUpdatingLocation()
        cb(location.coordinate, nil)
        self.locationCallback = nil
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      self.findUserLocation()
    }
  }
}
