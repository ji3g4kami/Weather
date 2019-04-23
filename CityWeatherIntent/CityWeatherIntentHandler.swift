//
//  CityWeatherIntentHandler.swift
//  CityWeatherIntent
//
//  Created by udn on 2019/4/22.
//  Copyright © 2019 dengli. All rights reserved.
//

import Foundation
import WeatherKit

class CityWeatherIntentHandler: NSObject, CityWeatherIntentHandling {
    
    func confirm(intent: CityWeatherIntent, completion: @escaping (CityWeatherIntentResponse) -> Void) {
        completion(CityWeatherIntentResponse(code: .ready, userActivity: nil))
    }

    func handle(intent: CityWeatherIntent, completion: @escaping (CityWeatherIntentResponse) -> Void) {
        let weatherManager = WeatherManager()
        let cities = weatherManager.cities
        guard let city = intent.city, cities.contains(city) else {
            completion(CityWeatherIntentResponse.failureNoCity(intent.city ?? "City"))
            return
        }
        weatherManager.getWeather(at: city) { weatherInfo in
            completion(CityWeatherIntentResponse.success(weather: weatherInfo.briefWeather, city: city))
        }
    }
}
