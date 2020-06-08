//
//  WeatherRequest.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherRequest {
    let latitude: String
    let longitude: String
}

extension WeatherRequest: RequestConvertible {
    var router: Router { return .weatherAPI }
    var path: String { return "weather?lat=\(latitude)&lon=\(longitude)" }
    var method: HTTPMethod { return .get }
    
    var parameters: Parameters? {
        return ["latitude": latitude,
                "longitude": longitude]
    }
}
