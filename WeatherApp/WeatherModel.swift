//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by DHwty on 08/07/2021.
//

import Foundation

struct WeatherModel: Decodable {
    let dt: Int
    let coord: Coord?
//    var weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
}

struct ForecastModel: Decodable {
    let city: City
    let message: Int
    let list: [WeatherModel]
}

struct City: Decodable {
    let coord: Coord
    let country: String

}

struct Coord: Decodable {
    let lon: Float
    let lat: Float
}

struct Weather: Decodable {
//    let id: Int
    let name: String
//    let main: String
//    let description: String
//    let icon: String
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

//struct Weather: Decodable {
//    let main: String
//    let describing: String
//    let icon: String
//}
//
//struct WeatherModel: Decodable {
//    var temperature: Double = 0
//    var maxTemperature: Double = 0
//    var minTemperature: Double = 0
//    var humidity: Double = 0
//    var pressure: Double = 0
//    var weather: [Weather] = [Weather]()
//
//    private enum WeatherModelKeys: String, CodingKey {
//        case main
//        case weather
//    }
//
//    private enum MainKeys: String, CodingKey {
//        case temperature = "temp"
//        case maxTemperature = "temp_max"
//        case minTemperature = "temp_min"
//        case humidity
//        case pressure
//    }
//
//    init(from decoder: Decoder) throws {
//        if let weatherModelContainer = try? decoder.container(keyedBy: WeatherModelKeys.self) {
//            if let mainCotainer = try? weatherModelContainer.nestedContainer(keyedBy: MainKeys.self, forKey: .main) {
//                self.temperature = try mainCotainer.decode(Double.self, forKey: .temperature)
//                self.maxTemperature = try mainCotainer.decode(Double.self, forKey: .maxTemperature)
//                self.minTemperature = try mainCotainer.decode(Double.self, forKey: .minTemperature)
//                self.humidity = try mainCotainer.decode(Double.self, forKey: .humidity)
//                self.pressure = try mainCotainer.decode(Double.self, forKey: .pressure)
//            }
//            self.weather = try weatherModelContainer.decode([Weather].self, forKey: WeatherModelKeys.weather)
//        }
//    }
//}
