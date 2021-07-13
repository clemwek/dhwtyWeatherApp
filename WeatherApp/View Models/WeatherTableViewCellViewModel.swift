//
//  WeatherTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by DHwty on 13/07/2021.
//

import UIKit.UIImage

public class WeatherTableViewCellViewModel {
    let weekday: String
    let icon: UIImage?
    let dayTemp: String
    
    init(weekday: String, icon: UIImage?, dayTemp: String) {
        self.weekday = weekday
        self.dayTemp = dayTemp
        self.icon = icon
    }
}
