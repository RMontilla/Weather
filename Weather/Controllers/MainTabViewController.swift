//
//  MainTabViewController.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import CoreLocation

class MainTabViewController: UITabBarController {
    //MARK: - Variables
    private var locationService: CoreLocationService {
        let locationService = CoreLocationService()
        locationService.startUpdating()
        return locationService
    }
    private let apiManager = APIManager()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarControllers()
    }
    
    //MARK: - Setup
    private func setupTabBarControllers() {
        guard let forecastController = R.storyboard.forecast().instantiateInitialViewController(creator: { [weak self] coder in
                  guard let self = self else { return nil }
                  return ForecastViewController(coder: coder, locationService: self.locationService, apiManager: self.apiManager)
              }),
              let weatherController = R.storyboard.weather().instantiateInitialViewController(creator: { [weak self] coder in
                  guard let self = self else { return nil }
                  return WeatherViewController(coder: coder, locationService: self.locationService, apiManager: self.apiManager)
              }) else {
                return
        }
        viewControllers = [weatherController, forecastController]
    }
}

