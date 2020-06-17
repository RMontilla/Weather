//
//  Router.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Alamofire

public enum Router {
    case weatherAPI
    case anotherAPI

    var baseURL: String {
        switch self {
        case .weatherAPI: return "http://api.openweathermap.org/data/2.5/"
        case .anotherAPI: return "http://api.openweathermap.org/data/2.5/"
        }
    }

    var apiKey: String? {
        switch self {
        case .weatherAPI: return "9afcefd5e22adba2c7e4b69db7b30b87"
        default: return nil
        }
    }
}

public protocol RequestConvertible: URLRequestConvertible {
    var parameters: Parameters? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var router: Router { get }
}

extension RequestConvertible {
    public func asURLRequest() throws -> URLRequest {
        var urlString = router.baseURL + path
        if let apiKey = router.apiKey { urlString += "&appid=\(apiKey)" }
        urlString += "&units=metric"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
