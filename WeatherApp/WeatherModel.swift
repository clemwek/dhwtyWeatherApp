//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by DHwty on 08/07/2021.
//

import Foundation

struct WeatherModel: Decodable {
    let dt: Int
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
}

struct ForecastModel: Decodable {
    let city: City
//    let list: [WeatherModel]
    let message: Int
}

struct City: Decodable {
    let coord: Coord
    let country: String
    
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let feelsLike: Float
    let temp: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Int
    let humidity: Int
}

struct Wind: Decodable {
    let deg: Float
    let speed: Float
}
