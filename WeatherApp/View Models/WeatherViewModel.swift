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
    var currentTemperature = Box("...")
    var minimunTemperature = Box("...")
    var maximumTemperature = Box("...")
    var weatherDescription = Box("...")
    
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
}
