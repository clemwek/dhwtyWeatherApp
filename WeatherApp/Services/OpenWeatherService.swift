//
//  OpenWeatherService.swift
//  WeatherApp
//
//  Created by DHwty on 12/07/2021.
//

import Foundation

enum OpenWeatherMapError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class OpenWeatherService {
    typealias WeatherDataCompletion = (WeatherModel?, OpenWeatherMapError?) -> ()
    typealias WeatherForecastDataCompletion = (ForecastModel?, OpenWeatherMapError?) -> ()
    
//    static func currentWeatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion)  {}
    
    static func currentWeatherDataForLocation(latitude: Double, longitude: Double, session: URLSession = .shared, completion: @escaping WeatherDataCompletion) {
        session.request(.fetchCurrentWeather(latitude: latitude, longitude: longitude)) { data, response, error in
            
            guard error == nil else {
                print("Failed request from Open Weather: \(error!.localizedDescription)")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No data returned from Open Weather")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process Open Weather response")
                completion(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failure response from Open Weather: \(response.statusCode)")
                completion(nil, .failedRequest)
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherModel = try decoder.decode(WeatherModel.self, from: data)
                completion(weatherModel, nil)
                
            } catch {
                print("Unable to decode Open Weather response: \(error.localizedDescription)")
                completion(nil, .invalidData)
            }
        }
    }
    
    static func forecastWeatherDataForLocation(latitude: Double, longitude: Double, session: URLSession = .shared, completion: @escaping WeatherForecastDataCompletion) {
        session.request(.fetchFiveDayWeather(latitude: latitude, longitude: longitude)) { data, response, error in
            
            guard error == nil else {
                print("Failed request from open Weather: \(error!.localizedDescription)")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No data returned from open Weather")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process Open Weather response")
                completion(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failure response from Ope Weather: \(response.statusCode)")
                completion(nil, .failedRequest)
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let forecastModel = try decoder.decode(ForecastModel.self, from: data)
                completion(forecastModel, nil)
                
            } catch {
                print("Unable to decode Weather response: \(error.localizedDescription)")
                completion(nil, .invalidData)
            }
        }
    }
}
