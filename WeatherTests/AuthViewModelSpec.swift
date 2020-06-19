//
//  AuthViewModelSpec.swift
//  WeatherTests
//
//  Created by Rafael Montilla on 2020/06/18.
//  Copyright © 2020 rafael. All rights reserved.
//

import Quick
import Nimble
import Combine
@testable import Weather

class AuthViewModelSpec: QuickSpec {
    override func spec() {
        
        describe("validation") {
            
            context("valid password but username length less than 4") {
                it("shouldn't be valid") {
                    //Arrange
                    let authModel = AuthViewModel()
                    
                    //Act
                    authModel.username = "Use"
                    authModel.password = "1234567"
                    
                    //Assert
                    _ = authModel.validUsername.sink {
                        expect($0).to(equal(false))
                    }
                    
                    _ = authModel.validCredentials.sink {
                        expect($0).to(equal(false))
                    }
                }
            }
            
            context("valid username but password length less than 6") {
                it("shouldn't be valid") {
                    //Arrange
                    let authModel = AuthViewModel()
                    //Act
                    authModel.username = "Username"
                    authModel.password = "12345"
                    //Assert
                    _ = authModel.validPassword.sink {
                        expect($0).to(equal(false))
                    }
                    
                    _ = authModel.validCredentials.sink {
                        expect($0).to(equal(false))
                    }
                }
            }
            
            context("valid username and valid password") {
                it("should be valid") {
                    //Arrange
                    let authModel = AuthViewModel()
                    //Act
                    authModel.username = "Username"
                    authModel.password = "1234567"
                    //Assert
                    _ = authModel.validCredentials.sink {
                        expect($0).to(equal(true))
                    }
                }
            }
        }
    }
}

