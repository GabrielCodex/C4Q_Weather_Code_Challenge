//
//  Weather.swift
//  TheWeatherMan
//
//  Created by Gabriel Breshears on 8/4/17.
//  Copyright © 2017 Gabriel Breshears. All rights reserved.
//

import Foundation




class Weather {
    
    let minTempFahrenheit: Int
    let maxTempFahrenheit: Int
    let dateTimeISO: String
    let weatherIcon: String
    
    
    
    init(minTempFahrenheit: Int, maxTempFahrenheit: Int, dateTimeISO: String, weatherIcon: String) {
        self.minTempFahrenheit = minTempFahrenheit
        self.maxTempFahrenheit = maxTempFahrenheit
        self.dateTimeISO = dateTimeISO
        self.weatherIcon = weatherIcon
        
    }
    
    convenience init?(dictionary: [String : Any]) {        
        
        guard let castedMinTempFahrenheit = dictionary["minTempF"] as? Int,
            let castedMaxTempFahrenheit = dictionary["maxTempF"] as? Int,
            let castedDateTimeISO = dictionary["dateTimeISO"] as? String,
            let castedWeatherIcon = dictionary["icon"] as? String else {return nil}
        
        self.init(minTempFahrenheit: castedMinTempFahrenheit, maxTempFahrenheit: castedMaxTempFahrenheit, dateTimeISO: castedDateTimeISO, weatherIcon: castedWeatherIcon)
        
        
        
    }
    
    
    
    static func buildForecastArray(from data: Data) -> [Weather]? {
        var forecastArray: [Weather] = []
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            // Remember Gabriel you are returning nil because if the Json is not an array of dictionary then my parasing won't do shit for it so I don't want it
            guard let jsonDictionary = jsonData as? [String : Any] else {return nil}
            guard let response = jsonDictionary["response"] as? [[String : Any]] else {return nil}
            
            for dictionaryRespone in response {
                
                guard let periods = dictionaryRespone["periods"] as? [[String : Any ]] else {return nil}
                
                for dictionary in periods {
                    guard let forecastDictionary = Weather(dictionary: dictionary) else {continue}
                    
                    forecastArray.append(forecastDictionary)
                }
            }
            
            
            
        } catch {
            print("problem parsing json: \(error)")
        }
        return forecastArray
    }
    
    
    
}
