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
