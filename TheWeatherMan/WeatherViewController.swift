//
//  ViewController.swift
//  TheWeatherMan
//
//  Created by Gabriel Breshears on 8/4/17.
//  Copyright © 2017 Gabriel Breshears. All rights reserved.
//

import UIKit


private let url = "https://api.aerisapi.com/forecasts/11101?client_id=\(clientID)&client_secret=\(clientSecret)"
private let clientID: String = "2D4wrIfEXq8FeyuUpf0yD"
private let clientSecret: String = "ITRl0b878gKUdHUWhUC10Dq8nFfQwmHipzTHgQ2G"
private let collectionCellIdentifier = "forecastCell"



class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conversionButton: UIButton!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    var forecast = [Weather]()
    var conversion: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherData()
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        conversionButton.setTitle("Change to Celsius", for: .normal)
        
        
        
    }
    
    func loadWeatherData(){
        
        APIRequestManager.manager.getData(endPoint: url) { ( data: Data?) in
            guard let unwrappedData = data else {return}
            
            self.forecast = Weather.buildForecastArray(from: unwrappedData)!
            DispatchQueue.main.async {
                self.forecastCollectionView.reloadData()
                dump(self.forecast)
            }
        }
    }
    
    func dateFormatter(date: String) -> String {
        let date = date
        let formattedDate =  String(date.characters.dropLast(15))
        return formattedDate
    }
    
    func celsius(from fahrenheit: Int) -> String {
        let celsiusDouble = Double(fahrenheit)
        
        let conversion = (celsiusDouble - 32) / 1.8
        
        return String(Int(conversion))
    }
    
    
    @IBAction func conversionPressed(_ sender: UIButton) {
        if conversion == false {
            conversion = true
            conversionButton.setTitle("Change to Fahrenheit", for: .normal)
            forecastCollectionView.reloadData()
        } else {
            conversion = false
            conversionButton.setTitle("Change to Celsius", for: .normal)
            forecastCollectionView.reloadData()
        }
        
    }
    
    
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! ForecastCollectionViewCell
        let weatherInfo = forecast[indexPath.row]
        
        if conversion == false {
            
            cell.highTempLabel.text = "High: \(celsius(from: weatherInfo.maxTempFahrenheit))ºC"
            cell.lowTempLabel.text = "Low: \(celsius(from: weatherInfo.minTempFahrenheit))ºC"
        } else {
            
            cell.highTempLabel.text = "High: \(weatherInfo.maxTempFahrenheit)ºF"
            cell.lowTempLabel.text = "Low: \(weatherInfo.minTempFahrenheit)ºF"
        }
        
        cell.dateLabel.text = dateFormatter(date: weatherInfo.dateTimeISO)
        cell.weatherIconImageView.image = UIImage(named: weatherInfo.weatherIcon)
        
        return cell
    }
    
    
}
