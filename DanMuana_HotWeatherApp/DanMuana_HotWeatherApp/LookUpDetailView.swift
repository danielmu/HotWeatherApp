//
//  LookUpDetailView.swift
//  DanMuana_HotWeatherApp
//
//  Created by Dan Muana on 11/3/21.
//

import UIKit

class LookUpDetailView: UIView {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    func configure(weather: Weather, main: Main) {
        tempLabel.text = "\(Int(main.temp))ºF"
        feelsLikeLabel.text = "Feels Like: \(Int(main.feelsLike))ºF"
        weatherDescriptionLabel.text = weather.weatherDescription
        weatherLabel.text = weather.main
    }
}
