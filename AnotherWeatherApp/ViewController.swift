//
//  ViewController.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 16-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import UIKit
import CoreLocation
//import MapKit

class ViewController: UIViewController {

    var weather: FullWeather!
    var geoCoder = CLGeocoder()

    //Location Variables
    let address = "h4n3b1"
    var location: String!
    var subLocation: String!
    
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    let locationManager = CLLocationManager()
    
    var unit = "F"
    
    
    @IBOutlet weak var locationLabel: UILabel!
//    @IBOutlet weak var subLocationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
//    @IBOutlet weak var summaryLabel: UILabel!
//    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailSummaryLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var weatherImage: RoundedImageView!
    
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var dayM3Label: UILabel!
    @IBOutlet weak var dayM2Label: UILabel!
    @IBOutlet weak var dayM1Label: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayP1Label: UILabel!
    @IBOutlet weak var dayP2Label: UILabel!
    @IBOutlet weak var dayP3Label: UILabel!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        print("hello")
//        print(self.weather.hourlyWeather.data)
        
        //Location
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        // TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        // CollectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        updateDate()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getDataFromString() {
        self.getLocation { () -> () in
            self.getDataFromLocation()
        }
    }
    
    func getDataFromLocation() {
//        self.subLocationLabel.hidden = true
        self.weather = FullWeather(latitude: "\(self.latitude)", longitude: "\(self.longitude)")
        self.locationLabel.text = self.location
        if self.subLocation != nil {
//            self.subLocationLabel.hidden = false
//            self.subLocationLabel.text = self.subLocation
            print(self.subLocation)
        } else {
//            self.subLocationLabel.hidden = true
        }
        
        self.weather.downloadWeatherData { () -> () in
            // Once weather fetched
            
            print("HourlyData: \(self.weather.hourlyWeather.data.count) results")
            print("DailyData: \(self.weather.dailyWeather.data.count) results")
            
            //                self.setBackgroundColor()
            self.updateUI()
            //                self.setChart(self.weather.hourlyTime, values: self.weather.hourlyTempC)
            //                print(self.weather.hourlyWeather[0].time)
            //                print(self.weather.hourlyWeather[self.weather.hourlyWeather.count - 1].time)
            
        }
    }

    func getLocation(completed: DownloadComplete) {
        geoCoder.geocodeAddressString(address) { (placemarks, error) -> Void in
            if error == nil {
                if let firstPlacemark = placemarks?[0] {
                    //                    print(firstPlacemark)
                    if let longitude = firstPlacemark.location?.coordinate.longitude, let latitude = firstPlacemark.location?.coordinate.latitude, let locality = firstPlacemark.locality {
                        self.latitude = latitude
                        self.longitude = longitude
                        self.location = locality
                        
                    }
                    if let subLocality = firstPlacemark.subLocality {
                        self.subLocation = subLocality
                    }
                    
                    completed()
                    
                    
//                    print(firstPlacemark.location?.coordinate.latitude)
//                    print(firstPlacemark.location?.coordinate.longitude)
//                    print(firstPlacemark.locality)
//                    print(firstPlacemark.subLocality)
//                    print(firstPlacemark.region)
//                    print(firstPlacemark.name)
//                    print(firstPlacemark.country)
                    
                }
            }
            
        }

    }

    func updateUI() {
//        self.iconLabel.text = self.weather.mainWeather.icon
        self.weatherImage.image = UIImage(named: "\(self.weather.mainWeather.icon)Top")
        
        let temp = "\(Int(round(self.weather.mainWeather.temperature)))ºF"
        let strokeString = NSMutableAttributedString(string: temp, attributes: [NSStrokeColorAttributeName : UIColor.blackColor(), NSStrokeWidthAttributeName: 1, NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        
        self.temperatureLabel.attributedText = strokeString
//        self.summaryLabel.text = self.weather.mainWeather.summary
//        self.weatherImageView.image = UIImage(named: self.weather.mainWeather.icon)
        self.detailSummaryLabel.text = self.weather.minutelyWeather.summary
        self.sunsetLabel.text = self.weather.dailyWeather.data[0].sunsetTime
        self.sunriseLabel.text = self.weather.dailyWeather.data[0].sunriseTime
        
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }

    
    @IBAction func changeUnitToMetricButtonPressed(sender: UIButton) {
        if weather != nil && unit == "F" {
            unit = "C"
            self.temperatureLabel.text = "\(Int(round(self.weather.mainWeather.temperatureC)))ºC"
            self.tableView.reloadData()
        }
//        print("Metric Pressed")
    }
    
    @IBAction func changeUnitToImperialButtonPressed(sender: AnyObject) {
        if weather != nil && unit == "C" {
            unit = "F"
            self.temperatureLabel.text = "\(Int(round(self.weather.mainWeather.temperature)))ºF"
            self.tableView.reloadData()
        }
    }
    
    func updateDate() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Weekday, .Month, .Year], fromDate: date)
        
        let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date)
        
        let weekDay = components.weekday
        let day = components.day
        let month = components.month
        let numDays = range.length
        let year = components.year
        
        
        
        if weekDay == 2 {
            self.mondayLabel.textColor = UIColor.orangeColor()
            self.mondayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        } else if weekDay == 3 {
            self.tuesdayLabel.textColor = UIColor.orangeColor()
            self.tuesdayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        } else if weekDay == 4 {
            self.wednesdayLabel.textColor = UIColor.orangeColor()
            self.wednesdayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        } else if weekDay == 5 {
            self.thursdayLabel.textColor = UIColor.orangeColor()
            self.thursdayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        } else if weekDay == 6 {
            self.fridayLabel.textColor = UIColor.orangeColor()
            self.fridayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        } else if weekDay == 7 {
            self.saturdayLabel.textColor = UIColor.orangeColor()
            self.mondayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        } else if weekDay == 1 {
            self.sundayLabel.textColor = UIColor.orangeColor()
            self.sundayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        }
        
        
        self.dayM3Label.text = "\(getDay("-", day: day, hmuch: 3, month: month, year: year))"
        self.dayM2Label.text = "\(getDay("-", day: day, hmuch: 2, month: month, year: year))"
        self.dayM1Label.text = "\(getDay("-", day: day, hmuch: 1, month: month, year: year))"
        self.dayLabel.text = "\(day)"
        self.dayLabel.textColor = UIColor.orangeColor()
        self.dayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        self.dayP1Label.text = "\(getDay("+", day: day, hmuch: 1, month: month, year: year))"
        self.dayP2Label.text = "\(getDay("+", day: day, hmuch: 2, month: month, year: year))"
        self.dayP3Label.text = "\(getDay("+", day: day, hmuch: 3, month: month, year: year))"
        
        
    }
    
//    enum month {
//        case 1 = 31;
//        case 2 = 28;
//    }
 
    func getDay(type: String, day: Int, hmuch: Int, month: Int, year: Int) -> Int {
        if type == "-" {
            if day - hmuch <= 0 {
                let result = day - hmuch
                let newDay: Int!
                
                if month - 1 == 0 {
                    newDay = getDaysInMonth(0, year: year - 1) + result
                } else {
                    newDay = getDaysInMonth(month - 1, year: year) + result
                }
                
                return newDay
            } else {
                return day - hmuch
            }
        } else {
            let dayInMonth = getDaysInMonth(month, year: year)
            if day + hmuch > dayInMonth {
                let result = day + hmuch - dayInMonth
                return result
            } else {
                return day + hmuch
            }
        }
        
    }
    
    func getDaysInMonth(month: Int, year: Int) -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        
        let startComps = NSDateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        
        let endComps = NSDateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
        
        let startDate = calendar.dateFromComponents(startComps)!
        let endDate = calendar.dateFromComponents(endComps)!
        
        let diff = calendar.components(NSCalendarUnit.Day, fromDate: startDate, toDate: endDate, options: NSCalendarOptions.MatchFirst)
        
        return diff.day
    }

    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return self.weather.hourlyWeather.data.count
        if weather != nil {
            return self.weather.dailyWeather.data.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? WeeklyForecastCell {
            cell.configureCell(self.weather.dailyWeather.data[indexPath.row], type: unit)
            return cell
        }
        else {
            return UITableViewCell()
        }
//        if weather != nil {
        
//        }
        
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Weekly Forecast"
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if weather != nil {
            return self.weather.hourlyWeather.data.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CCell", forIndexPath: indexPath) as? HourlyCell {
            cell.configureCell(self.weather.hourlyWeather.data[indexPath.item])
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.longitude = location.coordinate.longitude
            self.latitude = location.coordinate.latitude
            
            
            geoCoder.reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) in
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let firstPlacemark = placemarks![0] as CLPlacemark
                    self.longitude = firstPlacemark.location?.coordinate.longitude
                    self.latitude = firstPlacemark.location?.coordinate.latitude
                    self.location = firstPlacemark.locality
                    
                    if let subLocality = firstPlacemark.subLocality {
                        self.subLocation = subLocality
                    }
                    
                    self.getDataFromLocation()
                } else {
                    print("Problem with the data received from geocoder")
                    self.getDataFromString()
                }
            })
        }
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.getDataFromString()
        print(error.localizedDescription)
    }
    
    
}

