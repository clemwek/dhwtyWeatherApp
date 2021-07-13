//
//  Location.swift
//  WeatherApp
//
//  Created by DHwty on 12/07/2021.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let latitude: Double
    let longitude: Double
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}
