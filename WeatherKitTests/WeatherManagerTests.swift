//
//  WeatherManager.swift
//  WeatherTests
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import XCTest
@testable import WeatherKit


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
    
    func test_GetCityWeather_ParseData() {
        weatherManager.getWeather(at: "London") { weatherInfo in
            XCTAssertEqual(weatherInfo.cityName, "London")
        }
    }
}
