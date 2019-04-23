//
//  IntentHandler.swift
//  CityWeatherIntent
//
//  Created by udn on 2019/4/22.
//  Copyright © 2019 dengli. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        return CityWeatherIntentHandler()
    }
    
}
