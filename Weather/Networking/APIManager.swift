//
//  APIManager.swift
//  Weather
//
//  Created by rafaerum on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case noData
    case decodeError
    case customError(_ message: String)
    
    var errorDescription: String {
        switch self {
        case .noData: return "No data received"
        case .customError: return "Request error"
        default: return "Error"
        }
    }
}

final class APIManager {
    
    
    func makeRequest<T: Decodable>(target: RequestConvertible, completion: @escaping (Result<T, APIError>) -> Void) {
        
        AF.request(target)
          .validate(statusCode: 200...201)
          .responseDecodable(of: T.self) { (response) in
            if let errorDescription = response.error?.errorDescription {
                completion(.failure(.customError(errorDescription)))
                return
            }
            guard let value = response.value else {
                completion(.failure(.noData))
                return
            }
            completion(.success(value))
        }
        
    }
}
