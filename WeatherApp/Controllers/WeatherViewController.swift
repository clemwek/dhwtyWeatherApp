//
//  ViewController.swift
//  WeatherApp
//
//  Created by DHwty on 05/07/2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var minTempValue: UILabel!
    @IBOutlet weak var smallCurrentTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var largeCurrentTemp: UILabel!
    @IBOutlet weak var daysWeather: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    
    private let viewModel = WeatherViewModel()
    
    var locationManager = CLLocationManager()
    private let geocoder = LocationManager()
    
    var weekWeatherData = [WeatherTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTable.dataSource = self
        weatherTable.delegate = self
        
        viewModel.locationName.bind { [weak self] locationName in
            self?.cityLable.text = locationName
        }
        viewModel.currentTemperature.bind { [weak self] currentTemperature in
            self?.largeCurrentTemp.text = currentTemperature
            self?.smallCurrentTemp.text = currentTemperature
        }
        viewModel.minimunTemperature.bind { [weak self] minimumTemperature in
            self?.minTempValue.text = minimumTemperature
        }
        viewModel.maximumTemperature.bind { [weak self] maximumTemperature in
            self?.maxTemp.text = maximumTemperature
        }
        viewModel.weatherDescription.bind { [weak self] description in
            self?.daysWeather.text = description
        }
        viewModel.forecast.bind { [weak self] forecast in
            DispatchQueue.main.async {
                self?.weekWeatherData = forecast
                self?.weatherTable.reloadData()
            }
        }
        
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            viewModel.changeLocation(to: currentLoc)
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTable.dequeueReusableCell(withIdentifier: "cell") as! WeatherTableViewCell
        
        let dayWeather = weekWeatherData[indexPath.row]
        cell.dayLable.text = dayWeather.weekday
        cell.weatherIcon.image = UIImage(named: "clear")
        cell.daysTemp.text = dayWeather.dayTemp
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    
}

