//
//  APIManagerTests.swift
//  WeatherTests
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import XCTest
@testable import WeatherKit

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
        let urlString = API.sampleURL
        let promise = expectation(description: "Successfully get Data")
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

    func testUrlRequest() {
        // given
        let urlString = API.sampleURL
        let promise = expectation(description: "Successfully get Data")
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
    
    func testFailureUrlRequestWithResult() {
        // given
        let urlString = "Bad URL"
        let promise = expectation(description: "Invalid URL")
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
    
    func testFailureUrlRequest() {
        // given
        let urlString = "Bad URL"
        let promise = expectation(description: "Invalid URL")
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
    
    
    func testAPIWithHeaders() {
        // 台北
        let urlString = API.baseURL + "Taipei"
        let headers = [
            HeaderKey.RapidAPI_Host: API.RapidAPI_Host_URL,
            HeaderKey.RapidAPI_Key: RapidAPI_Key
        ]
        let promise = expectation(description: "Invalid URL request")
        var resultError: Error?
        var resultData: Data?
        
        // when
        apiManager.getData(from: urlString, headers: headers) { (result) in
            switch result {
            case .success(let data):
                resultData = data
                print(data)
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

}
