//
//  WeatherResponse.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation

struct Weather {
    let country: String
    let name: String
    let temperature: Float
    let humidity: Float
    let pressure: Float
    let precipitation: Float?
    let weatherCondition: WeatherCondition
    let windDirection: WindDirection
    let windSpeed: Float
}

extension Weather: Decodable {
    
    init(from decoder: Decoder) throws {
        let baseContainer =  try decoder.container(keyedBy: BaseKeys.self)
        let sysContainer = try baseContainer.nestedContainer(keyedBy: SysKeys.self, forKey: .sys)
        let mainContainer = try baseContainer.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        let windContainer = try baseContainer.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        let rainContainer = try? baseContainer.nestedContainer(keyedBy: RainKeys.self, forKey: .rain)
        var unkeyedContainer = try baseContainer.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try unkeyedContainer.nestedContainer(keyedBy: WeatherKeys.self)
        
        country = try sysContainer.decode(String.self, forKey: .country)
        name = try baseContainer.decode(String.self, forKey: .name)
        temperature = try mainContainer.decode(Float.self, forKey: .temp)
        humidity = try mainContainer.decode(Float.self, forKey: .humidity)
        precipitation = try? rainContainer?.decode(Float.self, forKey: .precipitation)
        pressure = try mainContainer.decode(Float.self, forKey: .pressure)
        let weatherId = try weatherContainer.decode(Int.self, forKey: .id)
        guard let weatherCondition = WeatherCondition(rawValue: weatherId) else {
            throw DecodingError.keyNotFound(WeatherKeys.id, DecodingError.Context(codingPath: [], debugDescription: "Weather ID not found \(weatherId)"))
        }
        self.weatherCondition = weatherCondition
        let windDegrees = try windContainer.decode(Double.self, forKey: .degrees)
        print("windDe \(windDegrees)")
        guard let windDirection = WindDirection(degrees: windDegrees) else {
            throw DecodingError.keyNotFound(WindKeys.degrees, DecodingError.Context(codingPath: [], debugDescription: "Wind degrees conversion error \(windDegrees)"))
        }
        print("windDirection \(windDirection)")
        self.windDirection = windDirection
        windSpeed = try windContainer.decode(Float.self, forKey: .speed)
    }
    
    private enum BaseKeys: String, CodingKey {
        case clouds, main, sys, weather, wind, name, rain
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
    
    private enum RainKeys: String, CodingKey {
        case precipitation = "1h"
    }
}
