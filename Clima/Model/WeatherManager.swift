//
//  WeatherManager.swift
//  Clima
//
//  Created by Adrian Senften on 08.02.23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager  {
    
    
    
    
    var apiKey = "bce03f1a3978daf477547dd30c0c61a5"
    

    
     
    
//    https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String) {
        let urlString = ("\(weatherURL)lat=\(latit)")
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. Create an URL
        
        if let url = URL(string: urlString) {
            //2. Create an URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
        

    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            print("Error")
            return nil
        }
    }
}
 

