//
//  WeatherViewModelSpec.swift
//  WeatherTests
//
//  Created by Rafael Montilla on 2020/06/19.
//  Copyright © 2020 rafael. All rights reserved.
//

import Quick
import Nimble
import Combine
@testable import Weather

class MockAPI: API {
    var lastPath: String = ""
    func makeRequest<T: Decodable>(target: RequestConvertible,
                                   completion: @escaping (Result<T, APIError>) -> Void) {
        lastPath = target.path
        
        let result = Weather(country: "Japan",
                             name: "Tokyo",
                             temperature: 26.9,
                             humidity: 83.4,
                             pressure: 1023.2,
                             precipitation: 4.2,
                             weatherCondition: .lightRain,
                             windDirection: .ESE,
                             windSpeed: 4.2)
        
        completion(.success(result as! T))
    }
}
class MockLocationService: CoreLocationService {
    var currentCoordinates = CurrentValueSubject<Location?, Never>(nil)
}

class WeatherViewModelSpec: QuickSpec {
    override func spec() {
        describe("core location") {
            context("coordinates have changed") {
                it("should call weather path") {
                    //Arrange
                    let mockAPI = MockAPI()
                    let mockLocationService = MockLocationService()
                    let weatherViewModel = WeatherViewModel(apiManager: mockAPI, locationService: mockLocationService)
                    let location = Location(latitude: "1", longitude: "1")
                    //Act
                    weatherViewModel.locationService.currentCoordinates.send(location)
                    //Assert
                    expect(mockAPI.lastPath.hasPrefix("weather?lat=1&lon=1")).to(equal(true))
                }
            }
        }
        
        describe("api response") {
            context("receives weather object") {
                it("should format correctly") {
                    //Arrange
                    let mockAPI = MockAPI()
                    let mockLocationService = MockLocationService()
                    let weatherViewModel = WeatherViewModel(apiManager: mockAPI, locationService: mockLocationService)
                    let location = Location(latitude: "1", longitude: "1")
                    //Act
                    weatherViewModel.locationService.currentCoordinates.send(location)
                    //Assert
                    expect(weatherViewModel.weatherImageName.value).to(equal(WeatherCondition.lightRain.dayImage))
                    expect(weatherViewModel.formattedLocation.value).to(equal("Tokyo, Japan"))
                    expect(weatherViewModel.weatherDescription.value).to(equal("26°C | \(WeatherCondition.lightRain.description)"))
                    expect(weatherViewModel.formattedLocation.value).to(equal("Tokyo, Japan"))
                    expect(weatherViewModel.humidity.value).to(equal("83.4%"))
                    expect(weatherViewModel.precipitation.value).to(equal("4.2 mm"))
                    expect(weatherViewModel.pressure.value).to(equal("1023.2 hPa"))
                    expect(weatherViewModel.windSpeed.value).to(equal("4.2 km/h"))
                }
            }
        }
    }
}


