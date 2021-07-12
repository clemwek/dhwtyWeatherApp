//
//  Networking.swift
//  WeatherApp
//
//  Created by DHwty on 07/07/2021.
//

import Foundation
import CoreLocation

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    let config = URLSessionConfiguration.default
    
    private init () {}
    
    public func fetchCurrentWeather () {
        
        let apiKey = "91a8c03fd97b06005b83e87c5e7ca53a"
        let city = "nairobi"
        
        //        let selectedUnits = UserDefaults.standard.object(forKey: "selectedUnit")
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            print("====================", response)
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    print("==================================>>>>>>: ", data)
                    let weatherModel = try decoder.decode(WeatherModel.self, from: data)
                    print("===================++++++++>>>>>>>>>>>>>: data ", weatherModel)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        })
        
        task.resume()
    }
    
//    public func fetchFiveDayWeather () {
//
//        let apiKey = "91a8c03fd97b06005b83e87c5e7ca53a"
//        let city = "nairobi"
//
//        //  let selectedUnits = UserDefaults.standard.object(forKey: "selectedUnit")
//        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)"
//        guard let url = URL(string: urlString) else { return }
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//            if let error = error {
//                print("Error with fetching films: \(error)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                print("Error with the response, unexpected status code: \(String(describing: response))")
//                return
//            }
//
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print("the json ============>>>>>>>>>>>: ", json)
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    print("==================================>>>>>>: ", data)
//                    let forecastModel = try decoder.decode(ForecastModel.self, from: data)
//                    print("===================++++++++>>>>>>>>>>>>>: data ", forecastModel)
//                } catch {
//                    print("JSON error: \(error.localizedDescription)")
//                }
//            }
//        })
//        task.resume()
//    }
    
    public func fetchWeather(city: String, using session: URLSession = .shared) {
        session.request(.fetchCurrentWeather(city: city)) { data, response, error in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("the json ============>>>>>>>>>>>: ", json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    print("==================================>>>>>>: ", data)
                    let currentModel = try decoder.decode(WeatherModel.self, from: data)
                    print("===================++++++++>>>>>>>>>>>>>: data ", currentModel)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    public func fetchForecastWeather(city: String, using session: URLSession = .shared) {
        session.request(.fetchFiveDayWeather(city: city)) { data, response, error in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("the json ============>>>>>>>>>>>: ", json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    print("==================================>>>>>>: ", data)
//                    let forecastModel = try decoder.decode(ForecastModel.self, from: data)
//                    print("===================++++++++>>>>>>>>>>>>>: data ", forecastModel)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
    }
}
