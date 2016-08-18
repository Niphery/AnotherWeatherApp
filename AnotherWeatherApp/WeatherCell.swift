//
//  WeatherCell.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 24-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var precipProbabilityLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(weather: Weather, type: String) {
        self.weatherImageView.image = UIImage(named: weather.icon)
        self.summaryLabel.text = weather.summary
        
        if type == "F" {
            self.temperatureLabel.text = "\(weather.temperature)º\(type)"
            self.apparentTemperatureLabel.text = "feel like \(weather.apparentTemperature)º\(type)"
        } else {
            self.temperatureLabel.text = "\(weather.temperatureC)º\(type)"
            self.apparentTemperatureLabel.text = "feel like \(weather.apparentTemperatureC)º\(type)"
        }
        
        self.precipProbabilityLabel.text = "Precipitation Probability: \(round(weather.precipProbability * 100))"
        
        
        let date = NSDate(timeIntervalSince1970: weather.time)
//        let formatter = NSDateFormatter()
//        formatter.localizedStringFromDate(date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        self.timeLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)

    }
    

}
