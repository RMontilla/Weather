//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Rafael Montilla on 2020/06/18.
//  Copyright © 2020 rafael. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let authModel = AuthViewModel()
        authModel.username = "Username"
        authModel.password = "1234567"
        
        _ = authModel.validCredentials.sink {
            XCTAssertEqual($0, false)
        }
    }
    
    func testNotValid() throws {
        let authModel = AuthViewModel()
        authModel.username = "Username"
        authModel.password = "12345678"
        
        _ = authModel.validCredentials.sink {
            XCTAssertEqual($0, true)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
