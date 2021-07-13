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
    
//    static func currentWeatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion)  {}
    
    static func currentWeatherDataForLocation(latitude: Double, longitude: Double, session: URLSession = .shared, completion: @escaping WeatherDataCompletion) {
        session.request(.fetchCurrentWeather(latitude: latitude, longitude: longitude)) { data, response, error in
            
            guard error == nil else {
                print("Failed request from Weatherbit: \(error!.localizedDescription)")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No data returned from Weatherbit")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process Weatherbit response")
                completion(nil, .invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failure response from Weatherbit: \(response.statusCode)")
                completion(nil, .failedRequest)
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("the json ============>>>>>>>>>>>: ", json)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print("==================================>>>>>>: ", data)
                let weatherModel = try decoder.decode(WeatherModel.self, from: data)
                print("============>>>>>>: ", weatherModel)
                completion(weatherModel, nil)
                
            } catch {
                print("Unable to decode Weather response: \(error.localizedDescription)")
                completion(nil, .invalidData)
            }
        }
    }
}
