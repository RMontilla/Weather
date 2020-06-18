//
//  AuthViewModel.swift
//  Weather
//
//  Created by rafaerum on 2020/06/18.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import Combine

class AuthViewModel {
    @Published var username: String = ""
    @Published var password: String = ""
    var validUsername: AnyPublisher<Bool, Never> {
        return $username
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count > 3 }
            .eraseToAnyPublisher()
    }
    var validPassword: AnyPublisher<Bool, Never> {
        return $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count > 8 }
            .eraseToAnyPublisher()
    }
    var validCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validUsername, validPassword)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
}
