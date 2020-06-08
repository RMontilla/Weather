//
//  ForecastRequest.swift
//  Weather
//
//  Created by rafaerum on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Alamofire

struct ForecastRequest {
    let latitude: String
    let longitude: String
}

extension ForecastRequest: RequestConvertible {
    var router: Router { return .weatherAPI }
    var path: String { return "forecast?lat=\(latitude)&lon=\(longitude)" }
    var method: HTTPMethod { return .get }
    
    var parameters: Parameters? {
        return ["latitude": latitude,
                "longitude": longitude]
    }
}
