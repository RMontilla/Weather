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
    var usernamePublisher = CurrentValueSubject<String?, Never>(nil)
    var passwordPublisher = CurrentValueSubject<String?, Never>(nil)
    var valid: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(usernamePublisher, passwordPublisher)
                          .map { (username, password) -> Bool in
                              guard let username = username,
                                    let password = password else { return false }
                              return !username.isEmpty && !password.isEmpty && password.count > 12
                          }
                          .eraseToAnyPublisher()
    }
}
