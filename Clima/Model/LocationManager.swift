//
//  LocationManager.swift
//  Clima
//
//  Created by Adrian Senften on 11.02.23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol LocationManagerDelegate {
    func didUpdateLocation(position: PositionModel)
}

struct LocationManager {

    let locationURL = "https://api.openweathermap.org/geo/1.0/direct?limit=5&appid=bce03f1a3978daf477547dd30c0c61a5"
    
    var lat: Double
    var lon: Double
    
    var delegate: LocationManagerDelegate?

    func fetchCity (cityName: String) {
       let urlString = ("\(locationURL)&q=\(cityName)")
       performRequest(urlString: urlString)
   }
    
     func performRequest(urlString: String) -> PositionModel? {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error")
                    return
                }
                if let safeData = data {
                    if let position = parseJSON(positionData: safeData) {
                       
                    }
                }
            }
            task.resume()
        }
          
        
    }
    

    
      func parseJSON(positionData: Data) -> PositionModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([PositionData].self, from: positionData)
            let lat = decodedData[0].lat
            let lon = decodedData[0].lon
            let positionData = PositionModel(lat: lat, lon: lon)
            return positionData
            
        } catch {
            print(error)
            return nil
        }
        }
    }
    

