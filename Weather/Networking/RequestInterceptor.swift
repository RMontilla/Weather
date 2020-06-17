//
//  RequestInterceptor.swift
//  Weather
//
//  Created by Rafael Motilla on 2020/06/17.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

final class RequestInterceptor: Alamofire.RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Router.weatherAPI.baseURL) == true else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") ?? ""
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        print("access \(accessToken)")
        completion(.success(urlRequest))
    }

    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }

        /*refreshToken { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let token):
                KeychainWrapper.standard.set(token, forKey: "accessToken")
                completion(.retry)
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
        }*/
    }
}
