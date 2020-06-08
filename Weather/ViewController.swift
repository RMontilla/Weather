//
//  ViewController.swift
//  Weather
//
//  Created by rafaerum on 2020/06/05.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    @IBOutlet private weak var refreshLocationButton: UIButton!
    @IBOutlet private weak var mapView: MKMapView!
    
    //MARK: - Variables
    
    private var locationManager: CLLocationManager?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMapView()
        setupCoreLocation()
    }
    
    //MARK: - Setup
    private func setupMapView() {
        
    }
    
    private func setupCoreLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager?.startUpdatingLocation()
        }
    }
    
    //MARK: - UI Actions
    @IBAction func refreshLocationButtonTapped(_ sender: Any) {
    }
}

//MARK: - API Calls
extension ViewController {
    private func fetchCurrentWeather(coordinate: CLLocationCoordinate2D) {
        let request = WeatherRequest(latitude: coordinate.latitude.description, longitude: coordinate.longitude.description)
        
        APIManager.shared.makeRequest(target: request) { (result: Result<WeatherResponse, APIError>) in
            switch result {
            case .success(let response):
                print("request done \(response)")
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
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
        latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        mapView.setCenter(userLocation.coordinate, animated: true)
        fetchCurrentWeather(coordinate: userLocation.coordinate)
    }
}

