//
//  WeatherResponse.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation

struct WeatherResponse {
    let country: String
    let name: String
    let temp: Float
    let humidity: Float
    let pressure: Float
    let weatherDescription: String
    let weatherIcon: String
    let weatherId: Int
    let windDegrees: Double
    let windSpeed: Float
}

extension WeatherResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let baseContainer =  try decoder.container(keyedBy: BaseKeys.self)
        let sysContainer = try baseContainer.nestedContainer(keyedBy: SysKeys.self, forKey: .sys)
        let mainContainer = try baseContainer.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        let windContainer = try baseContainer.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        var unkeyedContainer = try baseContainer.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try unkeyedContainer.nestedContainer(keyedBy: WeatherKeys.self)
        
        country = try sysContainer.decode(String.self, forKey: .country)
        name = try baseContainer.decode(String.self, forKey: .name)
        temp = try mainContainer.decode(Float.self, forKey: .temp)
        humidity = try mainContainer.decode(Float.self, forKey: .humidity)
        pressure = try mainContainer.decode(Float.self, forKey: .pressure)
        weatherId = try weatherContainer.decode(Int.self, forKey: .id)
        weatherIcon = try weatherContainer.decode(String.self, forKey: .icon)
        weatherDescription = try weatherContainer.decode(String.self, forKey: .description)
        windDegrees = try windContainer.decode(Double.self, forKey: .degrees)
        windSpeed = try windContainer.decode(Float.self, forKey: .speed)
    }
    
    private enum BaseKeys: String, CodingKey {
        case clouds, main, sys, weather, wind, name
    }
    
    private enum MainKeys: String, CodingKey {
        case humidity, pressure, temp
    }
    
    private enum SysKeys: String, CodingKey {
        case country
    }
    
    private enum WindKeys: String, CodingKey {
        case degrees = "deg"
        case speed
    }
    
    private enum WeatherKeys: String, CodingKey {
        case description, id, icon, main
    }
}
