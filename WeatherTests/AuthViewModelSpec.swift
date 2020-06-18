//
//  AuthViewModelSpec.swift
//  WeatherTests
//
//  Created by rafaerum on 2020/06/18.
//  Copyright © 2020 rafael. All rights reserved.
//

import Quick
import Nimble
@testable import Weather

class AuthViewModelSpec: QuickSpec {
    override func spec() {
        
        describe("simple test") {
            context("password lenght less than 7") {
                it("shouldn't be valid") {
                    let authModel = AuthViewModel()
                    authModel.username = "Username"
                    authModel.password = "12345678"
                    
                    _ = authModel.validCredentials.sink {
                        expect($0).to(equal(false))
                    }
                }
            }
        }
    }
}

