//
//  WeeklyForecastCell.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 29-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import UIKit

class WeeklyForecastCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func configureCell(weather: Weather, type: String) {
        self.weatherImageView.image = UIImage(named: weather.icon)
        
        
        self.summaryLabel.text = weather.summary
        
        if type == "F" {
            self.temperatureMaxLabel.text = "\(Int(round(weather.temperatureMax)))º\(type)"
            self.temperatureMinLabel.text = "\(Int(round(weather.temperatureMin)))º\(type)"
        } else {
            self.temperatureMaxLabel.text = "\(Int(round(weather.temperatureMaxC)))º\(type)"
            self.temperatureMinLabel.text = "\(Int(round(weather.temperatureMinC)))º\(type)"
        }
        
        let date = NSDate(timeIntervalSince1970: weather.time)
        //        let formatter = NSDateFormatter()
        //        formatter.localizedStringFromDate(date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        self.dayLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.FullStyle, timeStyle: NSDateFormatterStyle.NoStyle).capitalizedString
        
    }
    
    
}
