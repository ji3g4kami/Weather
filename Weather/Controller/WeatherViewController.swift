//
//  WeatherViewController.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import UIKit
import WeatherKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var cityName: String = "City"
    let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = cityName
        
        PendingIndicator.showActivityIndicatory(uiView: self.view)
        
        weatherManager.getWeather(at: cityName) { (weatherInfo) in
            self.updateUI(with: weatherInfo)
        }
    }
    
    private func updateUI(with weatherInfo: WeatherInfo) {
        DispatchQueue.main.async {
            self.navigationItem.title = weatherInfo.cityName
            self.weatherLabel.text = weatherInfo.briefWeather
            self.descriptionLabel.text = weatherInfo.descriptiveWeather
            self.minTempLabel.text = String(weatherInfo.temp_min)
            self.tempLabel.text = String(weatherInfo.temp)
            self.maxTempLabel.text = String(weatherInfo.temp_max)
            
            PendingIndicator.hideActivityIndicator()
        }
    }


}

