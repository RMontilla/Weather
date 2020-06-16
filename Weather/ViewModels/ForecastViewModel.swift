//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/16.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Combine

class ForecastViewModel {
    var cityName = CurrentValueSubject<String?, Never>(nil)
    var forecasts = CurrentValueSubject<[ForecastDayCellModel], Never>([])
    var errorMessage = CurrentValueSubject<String?, Never>(nil)
    
    let API: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.API = apiManager
    }
    
    //MARK: - Fetch methods
    func fetchForecast(_ location: Location) {
        let request = ForecastRequest(latitude: location.latitude, longitude: location.longitude)
        API.makeRequest(target: request) { [weak self] (result: Result<ForecastResponse, APIError>) in
            switch result {
            case .success(let response):
                self?.forecasts.send(response.forecasts)
                self?.cityName.send(response.cityName)
            case .failure(let error):
                self?.forecasts.send([])
                self?.cityName.send(nil)
                self?.errorMessage.send(error.localizedDescription)
            }
        }
    }
}
