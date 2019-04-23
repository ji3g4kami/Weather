//
//  CityTableViewController.swift
//  Weather
//
//  Created by udn on 2019/4/18.
//  Copyright © 2019 dengli. All rights reserved.
//

import UIKit
import WeatherKit

class CityTableViewController: UITableViewController {
    
    let citiesArray = WeatherManager().cities

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = citiesArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCityWeather", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityWeather" {
            guard let controller = segue.destination as? WeatherViewController,
                let index = tableView.indexPathForSelectedRow?.row else { return }
            controller.cityName = citiesArray[index]
        }
    }

}
