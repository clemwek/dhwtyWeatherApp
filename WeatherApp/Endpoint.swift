//
//  Endpoint.swift
//  WeatherApp
//
//  Created by DHwty on 08/07/2021.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

extension Endpoint {
    static func fetchCurrentWeather(city: String) -> Self {
        let apiKey = "c611c520417312134410fbe9eee3ea3e"
        return Endpoint(
            path: "weather",
            queryItems: [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: apiKey)
            ])
    }

    static func fetchFiveDayWeather(city: String) -> Self {
        let apiKey = "c611c520417312134410fbe9eee3ea3e"
        return Endpoint(
            path: "forecast",
            queryItems: [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "cnt", value: "2")
            ])
    }
}
