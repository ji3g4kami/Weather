//
//  WeatherManager.swift
//  WeatherTests
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherManagerTests: XCTestCase {

    var weatherManager: WeatherManager!
    
    override func setUp() {
        super.setUp()
        // set up the fake data and response
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "weather", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let url = URL(string: "https://does.not.matter")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        
        // inject the fake session into the app as a property of sut
        let apiManager = APIManager(session: sessionMock)
        weatherManager = WeatherManager(apiManager: apiManager)
    }
    
    override func tearDown() {
        weatherManager = nil
        super.tearDown()
    }
    
    func test_GetLondonWeather_ParseData() {
        weatherManager.getLondonWeather { (weatherInfo) in
            XCTAssertEqual(weatherInfo.cityName, "London")
        }
    }
    
    func test_GetLondonWeather_ParseData() {
        var cityName = ""
        let promise = expectation(description: "Parse in closure")
        weatherManager.getLondonWeather { (weatherInfo) in
            cityName = weatherInfo.cityName
            promise.fulfill()                       
        }
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(weatherInfo.cityName, "London")
    }
}
