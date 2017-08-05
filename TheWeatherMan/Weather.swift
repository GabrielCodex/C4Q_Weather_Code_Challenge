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
    let dateTimeISO: String?
    
    
    
    init(minTempFahrenheit: Int, maxTempFahrenheit: Int, dateTimeISO: String?) {
        self.minTempFahrenheit = minTempFahrenheit
        self.maxTempFahrenheit = maxTempFahrenheit
        self.dateTimeISO = dateTimeISO
        
    }
    
    convenience init?(dictionary: [String : Any]) {
        var dateTimeISO: String?
      
        
        guard let castedMinTempFahrenheit = dictionary["minTempF"] as? Int,
        let castedMaxTempFahrenheit = dictionary["maxTempF"] as? Int,
        let weatherCoded = dictionary["weatherCoded"] as? [[String : Any]] else {return nil}
        
        for dictionaryCoded in weatherCoded {
            
            guard let castedDateTimeISO = dictionaryCoded["dateTimeISO"] as? String else {return nil}
        
            dateTimeISO = castedDateTimeISO
        }
        
        self.init(minTempFahrenheit: castedMinTempFahrenheit, maxTempFahrenheit: castedMaxTempFahrenheit, dateTimeISO: dateTimeISO)
        
    
        
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
