//
//  ViewController.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PendingIndicator.showActivityIndicatory(uiView: self.view)
        
        weatherManager.getLondonWeather { [unowned self] (weatherInfo) in
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


}

