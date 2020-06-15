//
//  ForecastResponse.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation

struct ForecastResponse {
    var cityName: String
    var forecasts: [ForecastDay]
}

extension ForecastResponse: Decodable {
    private enum BaseKeys: String, CodingKey {
        case city, list
    }
    private enum CityKeys: String, CodingKey {
        case name
    }
    init(from decoder: Decoder) throws {
        let baseContainer =  try decoder.container(keyedBy: BaseKeys.self)
        let cityContainer = try baseContainer.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        cityName = try cityContainer.decode(String.self, forKey: .name)
        forecasts = try baseContainer.decode([ForecastDay].self, forKey: .list)
    }
}

struct ForecastDay {
    var temperature: Float
    var weatherCondition: WeatherCondition
    var time: Date
}

extension ForecastDay: Decodable {
    private enum BaseKeys: String, CodingKey {
        case main, weather
        case time = "dt_txt"
    }
    private enum MainKeys: String, CodingKey {
        case temperature = "temp"
    }
    private enum WeatherKeys: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: BaseKeys.self)
        let mainContainer = try baseContainer.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        var unkeyedContainer = try baseContainer.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try unkeyedContainer.nestedContainer(keyedBy: WeatherKeys.self)
        
        self.temperature = try mainContainer.decode(Float.self, forKey: .temperature)
        let weatherId = try weatherContainer.decode(Int.self, forKey: .id)
        guard let weatherCondition = WeatherCondition(rawValue: weatherId) else {
            throw DecodingError.keyNotFound(WeatherKeys.id, DecodingError.Context(codingPath: [], debugDescription: "Weather ID not found \(weatherId)"))
        }
        self.weatherCondition = weatherCondition
        self.time = try baseContainer.decode(Date.self, forKey: .time)
    }
}
