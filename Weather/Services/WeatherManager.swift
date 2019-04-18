//
//  WeatherManager.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import Foundation

let londonWeatherAPI = "https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b6907d289e10d714a6e88b30761fae22"

class WeatherManager {
    
    let apiManager: APIManager
    
    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getLondonWeather(completion: @escaping (WeatherInfo) -> Void) {
        apiManager.getData(from: londonWeatherAPI) { result in
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
