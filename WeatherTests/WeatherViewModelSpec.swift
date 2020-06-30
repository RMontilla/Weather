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
    func makeRequest<T>(target: RequestConvertible, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        lastPath = target.path
        return
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
                    expect(mockAPI.lastPath.hasPrefix("weather?")).to(equal(true))
                }
            }
        }
    }
}


