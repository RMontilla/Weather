//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/16.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Combine

class WeatherViewModel {
    var weatherImageName = CurrentValueSubject<String, Never>("")
    var formattedLocation = CurrentValueSubject<String?, Never>(nil)
    var weatherDescription = CurrentValueSubject<String?, Never>(nil)
    var humidity = CurrentValueSubject<String?, Never>(nil)
    var precipitation = CurrentValueSubject<String?, Never>(nil)
    var pressure = CurrentValueSubject<String?, Never>(nil)
    var windSpeed = CurrentValueSubject<String?, Never>(nil)
    var windDirection = CurrentValueSubject<String?, Never>(nil)
    var errorMessage = CurrentValueSubject<String?, Never>(nil)

    let API: APIManager
    init(apiManager: APIManager = APIManager()) {
        self.API = apiManager
    }
    // MARK: - Fetch methods
    func fetchCurrentWeather(_ location: Location) {
        let request = WeatherRequest(latitude: location.latitude, longitude: location.longitude)
        API.makeRequest(target: request) { [weak self] (result: Result<Weather, APIError>) in
            switch result {
            case .success(let weatherResponse):
                self?.formatWeatherInfo(weatherResponse)
            case .failure(let error):
                self?.errorMessage.send(error.errorDescription)
            }
        }
    }

    private func formatWeatherInfo(_ weather: Weather) {
        weatherImageName.send(weather.weatherCondition.dayImage)
        formattedLocation.send("\(weather.name), \(weather.country)")
        weatherDescription.send("\(Int(weather.temperature))°C | \(weather.weatherCondition.description)")
        humidity.send("\(weather.humidity)%")
        precipitation.send("\(weather.precipitation ?? 0) mm")
        pressure.send("\(weather.pressure) hPa")
        windSpeed.send("\(weather.windSpeed) km/h")
        windDirection.send("\(weather.windDirection)")
    }
}
