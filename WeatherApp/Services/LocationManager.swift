//
//  LocationManager.swift
//  WeatherApp
//
//  Created by DHwty on 12/07/2021.
//

import Foundation
import CoreLocation

class LocationManager {
    private lazy var geocoder = CLGeocoder()
    
    func geocode(addressString: String,
                 callback: @escaping ([Location]) -> ()) {
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            var locations: [Location] = []
            if let error = error {
                print("Geocoding error: (\(error))")
            } else {
                if let placemarks = placemarks {
                    locations = placemarks.compactMap { (placemark) -> Location? in
                        guard
                            let name = placemark.locality,
                            let location = placemark.location
                        else {
                            return nil
                        }
                        let region = placemark.administrativeArea ?? ""
                        let fullName = "\(name), \(region)"
                        return Location(
                            name: fullName,
                            latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude)
                    }
                }
            }
            callback(locations)
        }
    }
    
    func geocode(location: CLLocation,
                 callback: @escaping ([Location])
                    -> Void ) {
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            var locations: [Location] = []
            if let error = error {
                print("Geocoding error: (\(error))")
            } else {
                if let placemarks = placemarks {
                    locations = placemarks.compactMap { (placemark) -> Location? in
                        guard
                            let name = placemark.locality,
                            let location = placemark.location
                        else {
                            return nil
                        }
                        let region = placemark.administrativeArea ?? ""
                        let fullName = "\(name), \(region)"
                        return Location(
                            name: fullName,
                            latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude)
                    }
                }
            }
            callback(locations)
        }
    }
}
