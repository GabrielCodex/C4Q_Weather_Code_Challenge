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
    
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    var forecast = [Weather]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherData()
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
    
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
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! ForecastCollectionViewCell
        let weatherInfo = forecast[indexPath.row]
        
        cell.highTempLabel.text = "High: \(weatherInfo.maxTempFahrenheit)ºF"
        cell.lowTempLabel.text = "Low: \(weatherInfo.minTempFahrenheit)ºF"
        cell.dateLabel.text = weatherInfo.dateTimeISO ?? "No Date"

        //Would have changed the DateTimeISO To look better but out of time
        
        
        return cell
    }
    
    
}
