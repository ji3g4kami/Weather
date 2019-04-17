//
//  APIManagerTests.swift
//  WeatherTests
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import XCTest
@testable import Weather

class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!
    
    override func setUp() {
        super.setUp()
        apiManager = APIManager()
    }
    
    override func tearDown() {
        apiManager = nil
        super.tearDown()
    }
    
    func testUrlRequestWithResult() {
        // given
        let urlString = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
        let promise = expectation(description: "Invalid URL request")
        var resultError: Error?
        var resultData: Data?
        
        // when
        apiManager.getData(from: urlString) { (result) in
            switch result {
            case .success(let data):
                resultData = data
            case .failure(let error):
                resultError = error
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(resultData)
        XCTAssertNil(resultError)
    }
    
    func testFailUrlRequestWithResult() {
        // given 我把 samples 改成 sample
        let urlString = "https://sample.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
        let promise = expectation(description: "Invalid URL request")
        var resultError: Error?
        var resultData: Data?
        
        // when
        apiManager.getData(from: urlString) { (result) in
            switch result {
            case .success(let data):
                resultData = data
            case .failure(let error):
                resultError = error
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(resultError)
        XCTAssertNil(resultData)
    }

    func testUrlRequest() {
        // given
        let urlString = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
        let promise = expectation(description: "Invalid URL request")
        var responseError: Error?
        var responseData: Data?
        
        // when
        apiManager.getData(from: urlString) { data, response, error in
            responseError = error
            responseData = data
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(responseData)
        XCTAssertNil(responseError)
    }
    
    func testFailUrlRequest() {
        // given 我把 samples 改成 sample
        let urlString = "https://sample.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
        let promise = expectation(description: "Invalid URL request")
        var responseError: Error?
        var responseData: Data?
        
        // when
        apiManager.getData(from: urlString) { data, response, error in
            responseError = error
            responseData = data
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(responseError)
        XCTAssertNil(responseData)
    }

}
