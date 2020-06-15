//
//  MainTabViewController.swift
//  Weather
//
//  Created by rafaerum on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import CoreLocation

protocol MainLocationHandler: CLLocationManagerDelegate {
    var locationManager: CLLocationManager? { get set }
    func setupCoreLocation()
}

extension MainLocationHandler {
    func setupCoreLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager?.startUpdatingLocation()
        }
    }
}

class MainTabViewController: UITabBarController, MainLocationHandler {
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoreLocation()
    }
}
//MARK: - <# name #>
extension MainTabViewController {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways: break
        case .authorizedWhenInUse: break
        case .denied: break
        default: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        NotificationCenter.default.post(name: .locationUpdated, object: self, userInfo: [Constants.NotificationKeys.coordinate: userLocation.coordinate])
        locationManager?.stopUpdatingLocation()
    }
}
