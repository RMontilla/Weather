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
    // MARK: - Variables
    var cityName = CurrentValueSubject<String?, Never>(nil)
    var forecasts = CurrentValueSubject<[(String, [ForecastDay])], Never>([])
    var errorMessage = CurrentValueSubject<String?, Never>(nil)
    private var bag = Set<AnyCancellable>()

    // MARK: - Injected Properties
    let API: APIManager
    let locationService: CoreLocationService

    // MARK: - Init
    init(apiManager: APIManager = APIManager(), locationService: CoreLocationService) {
        self.API = apiManager
        self.locationService = locationService
        self.setup()
    }
    // MARK: - Setup
    func setup() {
        locationService.currentCoordinates
            .compactMap { $0 }
            .flatMap { location -> AnyPublisher<ForecastResponse, Never> in
                let target = ForecastRequest(latitude: location.latitude, longitude: location.longitude)
                let publisher = self.API.execute(target: target, returnedObject: ForecastResponse.self)
                return publisher.catch { (error) -> Just<ForecastResponse> in
                    self.errorMessage.value = error.errorDescription
                    return Just(ForecastResponse(cityName: "", forecasts: []))
                }.eraseToAnyPublisher()
            }
            .sink { response in
                let groupedArray = Dictionary(grouping: response.forecasts,
                                              by: { $0.formattedDay })
                    .map { ($0.key, $0.value) }
                    .sorted { $0.1[0].time < $1.1[0].time }
                self.forecasts.send(groupedArray)
                self.cityName.send(response.cityName)
            }
            .store(in: &bag)
    }

    // MARK: - Fetch methods
    func fetchForecast(_ location: Location) {
        let request = ForecastRequest(latitude: location.latitude, longitude: location.longitude)
        API.makeRequest(target: request) { [weak self] (result: Result<ForecastResponse, APIError>) in
            switch result {
            case .success(let response):
                let groupedArray = Dictionary(grouping: response.forecasts,
                                              by: { $0.formattedDay })
                    .map { ($0.key, $0.value) }
                    .sorted { $0.1[0].time < $1.1[0].time }
                self?.forecasts.send(groupedArray)
                self?.cityName.send(response.cityName)
            case .failure(let error):
                self?.forecasts.send([])
                self?.cityName.send(nil)
                self?.errorMessage.send(error.localizedDescription)
            }
        }
    }
}
