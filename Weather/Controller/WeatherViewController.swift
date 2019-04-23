//
//  WeatherViewController.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import UIKit
import Intents
import IntentsUI
import WeatherKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var cityName: String = "City"
    let weatherManager = WeatherManager()
    let siriButton = INUIAddVoiceShortcutButton(style: .whiteOutline)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = cityName
        
        PendingIndicator.showActivityIndicatory(uiView: self.view)
        
        weatherManager.getWeather(at: cityName) { (weatherInfo) in
            self.updateUI(with: weatherInfo)
        }
        
        addSiriButton(to: view)
    }
    
    func addSiriButton(to view: UIView) {
        siriButton.translatesAutoresizingMaskIntoConstraints = false
        
        // assign city weather intent to siri button
        let intent = CityWeatherIntent()
        intent.city = cityName
        intent.suggestedInvocationPhrase = "\(cityName)'s weather"
        siriButton.shortcut = INShortcut(intent: intent)
        
        // shortcut delegations
        siriButton.delegate = self
        view.addSubview(siriButton)
        view.centerXAnchor.constraint(equalTo: siriButton.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: siriButton.centerYAnchor).isActive = true
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


extension WeatherViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}


extension WeatherViewController: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

@available(iOS 12.0, *)
extension WeatherViewController: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
