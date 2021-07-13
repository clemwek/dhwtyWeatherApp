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
//    private let defaultAddress = "Chicago"

    private let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMM d"
      return dateFormatter
    }()

    private let tempFormatter: NumberFormatter = {
      let tempFormatter = NumberFormatter()
      tempFormatter.numberStyle = .none
      return tempFormatter
    }()
    
    let locationName = Box("Loading...")
    let currentTemperature = Box("...")
    let minimunTemperature = Box("...")
    let maximumTemperature = Box("...")
    let weatherDescription = Box("...")
    var forecast = Box([WeatherTableViewCellViewModel]())
    
    func changeLocation(to newLocation: String) {
      locationName.value = "Loading..."
      geocoder.geocode(addressString: newLocation) { [weak self] locations in
        guard let self = self else { return }
        if let location = locations.first {
          self.locationName.value = location.name
          self.fetchWeatherForLocation(location)
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
                self?.currentTemperature.value = "\(Int(weatherData.main.temp))"
                self?.minimunTemperature.value = "\(Int(weatherData.main.tempMin))"
                self?.maximumTemperature.value = "\(Int(weatherData.main.tempMax))"
                self?.weatherDescription.value = "\(weatherData.weather[0].main)"
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
                                              icon: self?.getImage(weather.weather[0].main),
                                              dayTemp: "\(Int(weather.main.temp))")
            })
        }
    }
    
    private func getImage(_ name: String) -> UIImage? {
        switch name {
        case "clear":
            return UIImage(named: "clear")
        case "partlysunny":
            return UIImage(named: "partlysunny")
        case "rain":
            return UIImage(named: "rain")
        default:
            return UIImage(named: "clear")
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
