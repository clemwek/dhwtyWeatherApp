//
//  ViewController.swift
//  WeatherApp
//
//  Created by DHwty on 05/07/2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var largeImg: UIImageView!
    @IBOutlet weak var tableBack: UIView!
    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var minTempValue: UILabel!
    @IBOutlet weak var smallCurrentTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var largeCurrentTemp: UILabel!
    @IBOutlet weak var daysWeather: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    
    @IBAction func showLocations(_ sender: Any) {
    }
    @IBAction func searchLocations(_ sender: Any) {
        showAlert()
    }
    
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
        viewModel.largeImg.bind { [weak self] largeImg in
            self?.largeImg.image = largeImg
        }
        viewModel.backgroundColor.bind { [weak self] bgColor in
            DispatchQueue.main.async {
                self?.tableBack.backgroundColor = bgColor
                self?.weatherTable.backgroundColor = bgColor
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
    
    func showAlert() {
        let alert = UIAlertController(title: "Get Weather",
                                      message: "Geat weather for a new city",
                                      preferredStyle: .alert)
        alert.addTextField { cityField in
            cityField.placeholder = "Enter city name"
        }
        alert.addAction(UIAlertAction(title: "search", style: .default, handler: { [weak alert] _ in
            if let textField = alert?.textFields![0],
               let city = textField.text,
               city != "" {
                self.viewModel.changeLocation(to: city)
            }
        }))
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel, handler: { _ in
                                        print("Tapped Dismiss")
                                      }))
        present(alert, animated: true, completion: nil)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTable.dequeueReusableCell(withIdentifier: "cell") as! WeatherTableViewCell
        
        let dayWeather = weekWeatherData[indexPath.row]
        cell.backgroundColor = dayWeather.bgColor
        cell.dayLable.text = dayWeather.weekday
        cell.weatherIcon.image = dayWeather.icon
        cell.daysTemp.text = dayWeather.dayTemp
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    
}
