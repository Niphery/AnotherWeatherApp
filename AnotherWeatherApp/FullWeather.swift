//
//  FullWeather.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 16-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import Foundation
import Alamofire

class FullWeather {
    
    private var _weatherURL: String!
    
    private var _offSet: Double!
    private var _units: String!
    
    private var _mainWeather: Weather!
    private var _minutelyWeather: ForecastWeather!
    private var _hourlyWeather: ForecastWeather!
    private var _dailyWeather: ForecastWeather!
    
    //Getters
    
    var mainWeather: Weather {
        return _mainWeather
    }
    var minutelyWeather: ForecastWeather {
        return _minutelyWeather
    }
    var hourlyWeather: ForecastWeather {
        return _hourlyWeather
    }
    var dailyWeather: ForecastWeather {
        return _dailyWeather
    }
    var offSet: Double {
        return _offSet
    }
    var units: String {
        return _units
    }
    
    
    //Initiateurs
    
    init(latitude: String, longitude: String) {
        self._weatherURL = "\(URL_WEATHER_BASE)\(API_KEY)\(latitude),\(longitude)"
    }
    
    //Functions
    
    func downloadWeatherData(completed: DownloadComplete) {
        let status: String!
        status = "dgsf"
        let url: NSURL!
        
        if status == "beta" {
            //Local Fetching
            let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")!
            url = NSURL(fileURLWithPath: path)
        } else {
            //Online Fetching
            url = NSURL(string: self._weatherURL)!
        }
        
        print(url)
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                //Get Offeset
                if let offset = dict["offset"] as? Double {
                    self._offSet = offset
                    print("OffSet: \(self._offSet)")
                }
                
                
                // Current Weather
                if let currently = dict["currently"] as? Dictionary<String, AnyObject> {
//                                        print(currently)
                    if let temperature = currently["temperature"] as? Double,
                        let apparentTemperature = currently["apparentTemperature"] as? Double,
                        let icon = currently["icon"] as? String,
                        let summary = currently["summary"] as? String,
                        let time = currently["time"] as? NSTimeInterval,
                        let windSpeed = currently["windSpeed"] as? Double,
                        let humidity = currently["humidity"] as? Double,
                        let nearestStormDistance = currently["nearestStormDistance"] as? Double,
                        let precipIntensity = currently["precipIntensity"] as? Double,
                        let precipProbability = currently["precipProbability"] as? Double,
                        let dewPoint = currently["dewPoint"] as? Double,
                        let windBearing = currently["windBearing"] as? Double,
                        let visibility = currently["visibility"] as? Double,
                        let cloudCover = currently["cloudCover"] as? Double,
                        let pressure = currently["pressure"] as? Double,
                        let ozone = currently["ozone"] as? Double
                    {

                        self._mainWeather = Weather(time: time, summary: summary, icon: icon, nearestStormDistance: nearestStormDistance, precipIntensity: precipIntensity,precipProbability: precipProbability , temperature: temperature, apparentTemperature: apparentTemperature, dewPoint: dewPoint, humidity: humidity, windSpeed: windSpeed, windBearing: windBearing, visibility: visibility, cloudCover: cloudCover, pressure: pressure, ozone: ozone)
                        print("CurrentTemp: \(self._mainWeather.temperature)ºF")
                        print("Summary: \(self._mainWeather.summary)")
                    }
                    
                } else {
                    print("ERROR: Current Weather Data not fetch")
                }
                
                
                // Minutely Weather
                if let minutely = dict["minutely"] as? Dictionary<String, AnyObject> {
                    if let icon = minutely["icon"] as? String , let summary = minutely["summary"] as? String {
                        self._minutelyWeather = ForecastWeather(sumary: summary, icon: icon)
                        print("MinSum: \(self._minutelyWeather.summary)")
                    }
                } else {
                    print("ERROR: Minute Weather Data not fetch")
                }
                
                // HourlyWeather
                if let hourly = dict["hourly"] as? Dictionary<String, AnyObject> {
                    if let icon = hourly["icon"] as? String, let summary = hourly["summary"] as? String {
                        //                        print(summary)
                        self._hourlyWeather = ForecastWeather(sumary: summary, icon: icon)
                    }

                    // Hourly Data
                    if let data = hourly["data"] as? [Dictionary<String, AnyObject>] {
//                                                print("DATA: \(data)")
                        for data in data {
//                            print(data)
                            if let temperature = data["temperature"] as? Double,
                                let apparentTemperature = data["apparentTemperature"] as? Double,
                                let icon = data["icon"] as? String,
                                let summary = data["summary"] as? String,
                                let time = data["time"] as? NSTimeInterval,
                                let windSpeed = data["windSpeed"] as? Double,
                                let humidity = data["humidity"] as? Double,
//                                let nearestStormDistance = data["nearestStormDistance"] as? Double,
                                let precipIntensity = data["precipIntensity"] as? Double,
                                let precipProbability = data["precipProbability"] as? Double,
                                let dewPoint = data["dewPoint"] as? Double,
                                let windBearing = data["windBearing"] as? Double,
                                let visibility = data["visibility"] as? Double,
                                let cloudCover = data["cloudCover"] as? Double,
                                let pressure = data["pressure"] as? Double,
                                let ozone = data["ozone"] as? Double
                            {
                                let weather = Weather(time: time, summary: summary, icon: icon, precipIntensity: precipIntensity,precipProbability: precipProbability, temperature: temperature, apparentTemperature: apparentTemperature, dewPoint: dewPoint, humidity: humidity, windSpeed: windSpeed, windBearing: windBearing, visibility: visibility, cloudCover: cloudCover, pressure: pressure, ozone: ozone)
                                
                                self._hourlyWeather.addData(weather)
                                
                            }
                            
                        }
                    }
                } else {
                    print("ERROR: Hour Weather Data not fetch")
                }
                
                
                // Daily Weather
                if let daily = dict["daily"] as? Dictionary<String, AnyObject> {
                    if let icon = daily["icon"] as? String, let summary = daily["summary"] as? String {
                        //                        print(summary)
                        self._dailyWeather = ForecastWeather(sumary: summary, icon: icon)
                    }

                    // Daily Data
                    if let data = daily["data"] as? [Dictionary<String, AnyObject>] {
                        //                        print(data)
                        for data in data {
//                            print(data)
                            if let time = data["time"] as? NSTimeInterval,
                                let summary = data["summary"] as? String,
                                let icon = data["icon"] as? String,

                                let sunriseTime = data["sunriseTime"] as? NSTimeInterval,
                                let sunsetTime = data["sunsetTime"] as? NSTimeInterval,
                                let moonPhase = data["moonPhase"] as? Double,
                                let precipIntensity = data["precipIntensity"] as? Double,
                                let precipIntensityMax = data["precipIntensityMax"] as? Double,
                                let precipProbability = data["precipProbability"] as? Double,
                                let temperatureMin = data["temperatureMin"] as? Double,
                                let temperatureMinTime = data["temperatureMinTime"] as? NSTimeInterval,
                                let temperatureMax = data["temperatureMax"] as? Double,
                                let temperatureMaxTime = data["temperatureMaxTime"] as? NSTimeInterval,
                                let apparentTemperatureMin = data["apparentTemperatureMin"] as? Double,
                                let apparentTemperatureMinTime = data["apparentTemperatureMinTime"] as? NSTimeInterval,
                                let apparentTemperatureMax = data["apparentTemperatureMax"] as? Double,
                                let apparentTemperatureMaxTime = data["apparentTemperatureMaxTime"] as? NSTimeInterval,
                                let dewPoint = data["dewPoint"] as? Double,
                                let humidity = data["humidity"] as? Double,
                                let windSpeed = data["windSpeed"] as? Double,
                                let windBearing = data["windBearing"] as? Double,
                                
                                let cloudCover = data["cloudCover"] as? Double,
                                let pressure = data["pressure"] as? Double,
                                let ozone = data["ozone"] as? Double

                            {
                                let weather: Weather!
                                if let visibility = data["visibility"] as? Double {
                                    weather = Weather(time: time, summary: summary, icon: icon, precipIntensity: precipIntensity, dewPoint: dewPoint, humidity: humidity, windSpeed: windSpeed, windBearing: windBearing, visibility: visibility, cloudCover: cloudCover, pressure: pressure, ozone: ozone, sunriseTime: sunriseTime, sunsetTime: sunsetTime, moonPhase: moonPhase, precipIntensityMax: precipIntensityMax, precipProbability: precipProbability, temperatureMin: temperatureMin, temperatureMinTime: temperatureMinTime, temperatureMax: temperatureMax, temperatureMaxTime: temperatureMaxTime, apparentTemperatureMin: apparentTemperatureMin, apparentTemperatureMinTime: apparentTemperatureMinTime, apparentTemperatureMax: apparentTemperatureMax, apparentTemperatureMaxTime: apparentTemperatureMaxTime)
                                } else {
                                    weather = Weather(time: time, summary: summary, icon: icon, precipIntensity: precipIntensity, dewPoint: dewPoint, humidity: humidity, windSpeed: windSpeed, windBearing: windBearing, cloudCover: cloudCover, pressure: pressure, ozone: ozone, sunriseTime: sunriseTime, sunsetTime: sunsetTime, moonPhase: moonPhase, precipIntensityMax: precipIntensityMax, precipProbability: precipProbability, temperatureMin: temperatureMin, temperatureMinTime: temperatureMinTime, temperatureMax: temperatureMax, temperatureMaxTime: temperatureMaxTime, apparentTemperatureMin: apparentTemperatureMin, apparentTemperatureMinTime: apparentTemperatureMinTime, apparentTemperatureMax: apparentTemperatureMax, apparentTemperatureMaxTime: apparentTemperatureMaxTime)
                                }
                                
                                

//                                print("+1")
                                self._dailyWeather.addData(weather)
                                
                            } else {
                               print("data: \(data)")
                            }
                            
                        }
                    }
                } else {
                    print("ERROR: Daily Weather Data not fetch")
                }
                
                
                // Flags Units
                if let flags = dict["flags"] as? Dictionary<String, AnyObject> {
                    if let units = flags["units"] as? String {
                        print("Units: \(units)")
                        self._units = units
                    }
                }
                
                
                
                
            }
            completed()
        }
    }
    
    // Helpers
    
    
}