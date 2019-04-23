//
//  WeatherManager.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import Foundation

public class WeatherManager {
    
    public var cities: [String] = ["Taipei", "Tainan", "London", "Vancouver"]
    
    public let apiManager: APIManager
    
    public init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    public func getWeather(at city: String, completion: @escaping (WeatherInfo) -> Void) {
        let headers = [
            HeaderKey.RapidAPI_Host: API.RapidAPI_Host_URL,
            HeaderKey.RapidAPI_Key: RapidAPI_Key
        ]
        apiManager.getData(from: API.baseURL + city, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(LocWeather.self, from: data)
                    let weatherInfo = WeatherInfo(
                        cityName: weather.name,
                        briefWeather: weather.weather[0].main,
                        descriptiveWeather: weather.weather[0].description,
                        temp: weather.main.temp,
                        pressure: weather.main.pressure,
                        humidity: weather.main.humidity,
                        temp_min: weather.main.temp_min,
                        temp_max: weather.main.temp_max
                    )
                    completion(weatherInfo)
                } catch {
                    print("Decoder failed", error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getLondonWeather(completion: @escaping (WeatherInfo) -> Void) {
        let headers = [
            HeaderKey.RapidAPI_Host: API.RapidAPI_Host_URL,
            HeaderKey.RapidAPI_Key: RapidAPI_Key
        ]
        apiManager.getData(from: API.baseURL + "Taipei", headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(LocWeather.self, from: data)
                    let weatherInfo = WeatherInfo(
                        cityName: weather.name,
                        briefWeather: weather.weather[0].main,
                        descriptiveWeather: weather.weather[0].description,
                        temp: weather.main.temp,
                        pressure: weather.main.pressure,
                        humidity: weather.main.humidity,
                        temp_min: weather.main.temp_min,
                        temp_max: weather.main.temp_max
                    )
                    completion(weatherInfo)
                } catch {
                    print("Decoder failed", error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
