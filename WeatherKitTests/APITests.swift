//
//  APITests.swift
//  WeatherTests
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import XCTest
@testable import WeatherKit

class APITests: XCTestCase {

    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        urlSession = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        urlSession = nil
        super.tearDown()
    }
    
    func testCallToLondonWeatherCompletes() {
        callTo(urlString: API.sampleURL)
    }
    
    func callTo(urlString: String) {
        /// given
        let url = URL(string: urlString)
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = urlSession.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}



