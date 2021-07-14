//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by DHwty on 12/07/2021.
//

import UIKit.UIImage
import CoreLocation

public class WeatherViewModel {
    private let geocoder = LocationManager()
    
    let locationName = Box("Loading...")
    let currentTemperature = Box("...")
    let minimunTemperature = Box("...")
    let maximumTemperature = Box("...")
    let weatherDescription = Box("...")
    let largeImg: Box<UIImage?> = Box(UIImage.sunny)
    let backgroundColor: Box<UIColor> = Box(.sunny)
    var forecast = Box([WeatherTableViewCellViewModel]())
    
    func changeLocation(to newLocation: String) {
        locationName.value = "Loading..."
        geocoder.geocode(addressString: newLocation) { [weak self] locations in
            guard let self = self else { return }
            if let location = locations.first {
                self.locationName.value = location.name
                self.fetchWeatherForLocation(location)
                self.fetchWeekWeatherForLocation(location)
                return
            }
        }
    }
    
    func changeLocation(to newLocation: CLLocation) {
        locationName.value = "Loading..."
        geocoder.geocode(location: newLocation) { [weak self] locations in
            guard let self = self else { return }
            if let location = locations.first {
                self.locationName.value = location.name
                self.fetchWeatherForLocation(location)
                self.fetchWeekWeatherForLocation(location)
                return
            }
        }
    }
    
    private func fetchWeatherForLocation(_ location: Location) {
        OpenWeatherService.currentWeatherDataForLocation(latitude: location.latitude, longitude: location.longitude) { [weak self] (weatherData, error) in
            guard
                let _ = self,
                let weatherData = weatherData
            else {
                return
            }
            DispatchQueue.main.async {
                self?.currentTemperature.value = "\(Int(weatherData.main.temp))°"
                self?.minimunTemperature.value = "\(Int(weatherData.main.tempMin))°"
                self?.maximumTemperature.value = "\(Int(weatherData.main.tempMax))°"
                self?.weatherDescription.value = "\(weatherData.weather[0].main)"
                self?.largeImg.value = self?.updateImg(weatherData.weather[0].main)
                self?.backgroundColor.value = self?.updateColor(weatherData.weather[0].main) ?? UIColor.clear
            }
        }
        
    }
    
    private func fetchWeekWeatherForLocation(_ location: Location) {
        OpenWeatherService.forecastWeatherDataForLocation(latitude: location.latitude, longitude: location.longitude) { [weak self] (farecastData, error) in
            guard
                let _ = self,
                let farecastData = farecastData
            else {
                return
            }
            var count = 0
            let forecastList = farecastData.list.filter { weather -> Bool in
                count += 1
                return count % 8 == 0
            }
            self?.forecast.value = forecastList.map({ weather in
                
                WeatherTableViewCellViewModel(weekday: self?.getDay(Double(weather.dt)) ?? "",
                                              icon: self?.updateIcon(weather.weather[0].main),
                                              dayTemp: "\(Int(weather.main.temp))°",
                                              bgColor: self?.updateColor(weather.weather[0].main) ?? UIColor.clear)
            })
        }
    }
    
    private func updateColor(_ name: String) -> UIColor {
        switch name {
        case "Clear":
            return UIColor.clear
        case "partly sunny", "Clouds":
            return UIColor.cloudy
        case "rain":
            return UIColor.rainy
        default:
            return UIColor.clear
        }
    }
    
    private func updateImg(_ name: String) -> UIImage? {
        switch name {
        case "Clear":
            return UIImage.sunny
        case "partly sunny", "Clouds":
            return UIImage.cloudy
        case "rain":
            return UIImage.rainny
        default:
            return UIImage(named: "clear")
        }
    }
    
    private func updateIcon(_ name: String) -> UIImage? {
        switch name {
        case "clear":
            return UIImage.clearIcon
        case "clouds", "Clouds":
            return UIImage.cloudIcon
        case "rain":
            return UIImage.rainIcon
        default:
            return UIImage.clearIcon
        }
    }
    
    private func getDay(_ dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let day = date.get(.weekday)
        switch day {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
}
