//
//  HourlyCell.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 01-04-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import UIKit

class HourlyCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    func configureCell(weather: Weather) {
        
        let date = NSDate(timeIntervalSince1970: weather.time)
        //        let formatter = NSDateFormatter()
        //        formatter.localizedStringFromDate(date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        self.timeLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle).capitalizedString
        
//        self.timeLabel.text = "\(weather.time)"
        self.summaryLabel.text = weather.summary
        self.iconImage.image = UIImage(named: weather.icon)
    }
}
