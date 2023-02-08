//
//  WeatherManager.swift
//  Clima
//
//  Created by Adrian Senften on 08.02.23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=bce03f1a3978daf477547dd30c0c61a5"
    
    func fetchWeather (cityName: String) {
        let urlString = ("\(weatherURL)&q\(cityName)")
    }
}
