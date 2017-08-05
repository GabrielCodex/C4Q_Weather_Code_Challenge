//
//  ForecastCollectionViewCell.swift
//  TheWeatherMan
//
//  Created by Gabriel Breshears on 8/4/17.
//  Copyright © 2017 Gabriel Breshears. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    
    @IBOutlet weak var lowTempLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
}
