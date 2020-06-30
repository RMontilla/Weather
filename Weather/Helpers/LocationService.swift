//
//  CoreLocationService.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/16.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

struct Location {
    let latitude: String
    let longitude: String
}

protocol CoreLocationService {
    var currentCoordinates: CurrentValueSubject<Location?, Never> { get set }
}

class LocationService: NSObject, CoreLocationService, CLLocationManagerDelegate {
    var currentCoordinates: CurrentValueSubject<Location?, Never> = .init(nil)
    private var locationManager: CLLocationManager

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
    }

    public func startUpdating() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }

    // MARK: - Delegate methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways: break
        case .authorizedWhenInUse: break
        case .denied: break
        default: break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates = locations[0].coordinate
        currentCoordinates.send(.init(latitude: coordinates.latitude.description,
                                      longitude: coordinates.longitude.description))
        locationManager.stopUpdatingLocation()
    }
}
