//
//  Decodables.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

public struct LocWeather: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

public struct Main: Decodable {
    let temp: Float
    let pressure: Int
    let humidity: Int
    let temp_min: Float
    let temp_max: Float
}

public struct Weather: Decodable {
    let main: String
    let description: String
}

public struct WeatherInfo {
    public let cityName: String
    public let briefWeather: String
    public let descriptiveWeather: String
    public let temp: Float
    public let pressure: Int
    public let humidity: Int
    public let temp_min: Float
    public let temp_max: Float
}
