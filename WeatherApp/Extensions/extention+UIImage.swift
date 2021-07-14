//
//  extention+UIImage.swift
//  WeatherApp
//
//  Created by DHwty on 14/07/2021.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    static var sunny: UIImage? {
        UIImage(named: "forest_sunny")
    }
    static var rainny: UIImage? {
        UIImage(named: "forest_rainy")
    }
    static var cloudy: UIImage? {
        UIImage(named: "forest_cloudy")
    }
    
    static var clearIcon: UIImage? {
        UIImage(named: "clear")
    }
    static var rainIcon: UIImage? {
        UIImage(named: "rain")
    }
    static var cloudIcon: UIImage? {
        UIImage(named: "partlysunny")
    }
}
