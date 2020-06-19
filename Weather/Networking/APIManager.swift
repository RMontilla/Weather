//
//  APIManager.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/08.
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
        case .noData: return L10n.Error.noData
        case .customError(let message): return message
        default: return L10n.Error.genericError
        }
    }
}

protocol API: class {
    func makeRequest<T:Decodable>(target: RequestConvertible,
                                  completion: @escaping (Result<T, APIError>) -> Void)
}

final class APIManager: API {
    private let session = Session(interceptor: RequestInterceptor())

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }

    public func makeRequest<T: Decodable>(target: RequestConvertible,
                                          completion: @escaping (Result<T, APIError>) -> Void) {
        session.request(target)
               .validate(statusCode: 200...300)
               .responseDecodable(of: T.self, decoder: decoder) { (response) in
                    print("response")
                    if let data = response.data,
                       let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("json \(json)")
                    }
                    if let errorDescription = response.error?.errorDescription {
                        print("errorDescription \(errorDescription)")
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
