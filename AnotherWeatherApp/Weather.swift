//
//  Weather.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 16-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import Foundation

class Weather {
    private var _time: NSTimeInterval!  //c//h//d
    private var _summary: String!   //c//h//d
    private var _icon: String!  //c//h//d
    
    private var _precipIntensity: Double!   //c//h//d
    private var _precipProbability: Double! //c//h//d
    
    private var _dewPoint: Double!  //c//h//d
    private var _humidity: Double!  //c//h//d
    private var _windSpeed: Double! //c//h//d
    private var _windBearing: Double!   //c//h//d
    private var _visibility: Double!    //c//h//d
    private var _cloudCover: Double!    //c//h//d
    private var _pressure: Double!  //c//h//d
    private var _ozone: Double! //c//h//d
    
    private var _precipType: String?    //h//d
    
    private var _nearestStormDistance: Double?  //c
    
    private var _nearestStormBearing: Double?   //c
    private var _temperature: Double?   //c//h
    private var _apparentTemperature: Double?   //c//h
    
    private var _sunriseTime: NSTimeInterval?   //d
    private var _sunsetTime: NSTimeInterval?    //d
    private var _moonPhase: Double? //d
    private var _precipIntensityMax: Double?    //d
    private var _precipIntensityMaxTime: NSTimeInterval?   //d
    
    private var _temperatureMin: Double?    //d
    private var _temperatureMinTime: NSTimeInterval?    //d
    private var _temperatureMax: Double?    //d
    private var _temperatureMaxTime: NSTimeInterval?    //d
    private var _apparentTemperatureMin: Double?    //d
    private var _apparentTemperatureMinTime: NSTimeInterval?    //d
    private var _apparentTemperatureMax: Double?    //d
    private var _apparentTemperatureMaxTime: NSTimeInterval?    //d
    
    
    //Getters 
    
    var time: NSTimeInterval {
        return _time
    }
    var summary: String {
        return _summary
    }
    var icon: String {
        return _icon
    }
    
    var precipIntensity: Double {
        return _precipIntensity
    }
    var precipProbability: Double {
        return _precipProbability
    }
    
    var dewPoint: Double {
        return _dewPoint
    }
    var humidity: Double {
        return _humidity
    }
    var windSpeed: Double {
        return _windSpeed
    }
    var windBearing: Double {
        return _windBearing
    }
    var visibility: Double {
        return _visibility
    }
    var cloudCover: Double {
        return _cloudCover
    }
    var pressure: Double {
        return _pressure
    }
    var ozone: Double {
        return _ozone
    }
    
    var precipType: String {
        return _precipType!
    }
    var nearestStormDistance: Double {
        return _nearestStormDistance!
    }
    var temperature: Double {
        return _temperature!
    }
    var temperatureC: Double {
        return convertFtoC(_temperature!)
    }
    var apparentTemperature: Double {
        return _apparentTemperature!
    }
    var apparentTemperatureC: Double {
        return convertFtoC(_apparentTemperature!)
    }
    
    var sunriseTime: String {
        let date = NSDate(timeIntervalSince1970: _sunriseTime!)
        return NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle).capitalizedString
    }
    var sunsetTime: String {
        let date = NSDate(timeIntervalSince1970: _sunsetTime!)
        return NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle).capitalizedString
    }
    var moonPhase: Double {
        return _moonPhase!
    }
    var precipIntensityMax: Double {
        return _precipIntensityMax!
    }
    var precipIntensityMaxTime: NSTimeInterval {
        return _precipIntensityMaxTime!
    }
    
    var temperatureMin: Double {
        return _temperatureMin!
    }
    var temperatureMinC: Double {
        return convertFtoC(_temperatureMin!)
    }
    var temperatureMinTime: NSTimeInterval {
        return _temperatureMinTime!
    }
    var temperatureMax: Double {
        return _temperatureMax!
    }
    var temperatureMaxC: Double {
        return convertFtoC(_temperatureMax!)
    }
    var temperatureMaxTime: NSTimeInterval {
        return _temperatureMaxTime!
    }
    var apparentTemperatureMin: Double {
        return _apparentTemperatureMin!
    }
    var apparentTemperatureMinC: Double {
        return convertFtoC(_apparentTemperatureMin!)
    }
    var apparentTemperatureMinTime: NSTimeInterval {
        return _apparentTemperatureMinTime!
    }
    var apparentTemperatureMax: Double{
        return _apparentTemperatureMax!
    }
    var apparentTemperatureMaxC: Double {
        return convertFtoC(_apparentTemperatureMax!)
    }
    var apparentTemperatureMaxTime: NSTimeInterval{
        return _apparentTemperatureMaxTime!
    }
    
    
    
    //Initiateur

    init(time: NSTimeInterval, summary: String, icon: String, nearestStormDistance: Double, precipIntensity: Double,precipProbability: Double, temperature: Double, apparentTemperature: Double, dewPoint: Double, humidity: Double, windSpeed: Double, windBearing: Double, visibility: Double, cloudCover: Double, pressure: Double, ozone: Double) {
        self._time = time
        self._summary = summary
        self._icon = icon
        self._nearestStormDistance = nearestStormDistance
        self._precipIntensity = precipIntensity
        self._precipProbability = precipProbability
        self._temperature = temperature
        self._apparentTemperature = apparentTemperature
        self._dewPoint = dewPoint
        self._humidity = humidity
        self._windSpeed = windSpeed
        self._windBearing = windBearing
        self._visibility = visibility
        self._cloudCover = cloudCover
        self._pressure = pressure
        self._ozone = ozone
    }
    
    init(time: NSTimeInterval, summary: String, icon: String, precipIntensity: Double,precipProbability: Double, temperature: Double, apparentTemperature: Double, dewPoint: Double, humidity: Double, windSpeed: Double, windBearing: Double, visibility: Double, cloudCover: Double, pressure: Double, ozone: Double) {
        self._time = time
        self._summary = summary
        self._icon = icon
        self._precipIntensity = precipIntensity
        self._precipProbability = precipProbability
        self._temperature = temperature
        self._apparentTemperature = apparentTemperature
        self._dewPoint = dewPoint
        self._humidity = humidity
        self._windSpeed = windSpeed
        self._windBearing = windBearing
        self._visibility = visibility
        self._cloudCover = cloudCover
        self._pressure = pressure
        self._ozone = ozone
    }
    
    init(time: NSTimeInterval, summary: String, icon: String, precipIntensity: Double, dewPoint: Double, humidity: Double, windSpeed: Double, windBearing: Double, visibility: Double, cloudCover: Double, pressure: Double, ozone: Double, sunriseTime: NSTimeInterval, sunsetTime: NSTimeInterval, moonPhase: Double, precipIntensityMax: Double, precipProbability: Double, temperatureMin: Double, temperatureMinTime: NSTimeInterval, temperatureMax: Double, temperatureMaxTime: NSTimeInterval, apparentTemperatureMin: Double, apparentTemperatureMinTime: NSTimeInterval, apparentTemperatureMax: Double, apparentTemperatureMaxTime: NSTimeInterval ) {
        
        self._time = time
        self._summary = summary
        self._icon = icon
        
        self._sunriseTime = sunriseTime
        self._sunsetTime = sunsetTime
        self._moonPhase = moonPhase
        self._precipIntensity = precipIntensity
        self._precipIntensityMax = precipIntensityMax
        self._precipProbability = precipProbability
        self._temperatureMin = temperatureMin
        self._temperatureMinTime = temperatureMinTime
        self._temperatureMax = temperatureMax
        self._temperatureMaxTime = temperatureMaxTime
        self._apparentTemperatureMin = apparentTemperatureMin
        self._apparentTemperatureMinTime = apparentTemperatureMinTime
        self._apparentTemperatureMax = apparentTemperatureMax
        self._apparentTemperatureMaxTime = apparentTemperatureMaxTime
        
        self._dewPoint = dewPoint
        self._humidity = humidity
        self._windSpeed = windSpeed
        self._windBearing = windBearing
        self._visibility = visibility
        self._cloudCover = cloudCover
        self._pressure = pressure
        self._ozone = ozone
        
    }
    
    init(time: NSTimeInterval, summary: String, icon: String, precipIntensity: Double, dewPoint: Double, humidity: Double, windSpeed: Double, windBearing: Double, cloudCover: Double, pressure: Double, ozone: Double, sunriseTime: NSTimeInterval, sunsetTime: NSTimeInterval, moonPhase: Double, precipIntensityMax: Double, precipProbability: Double, temperatureMin: Double, temperatureMinTime: NSTimeInterval, temperatureMax: Double, temperatureMaxTime: NSTimeInterval, apparentTemperatureMin: Double, apparentTemperatureMinTime: NSTimeInterval, apparentTemperatureMax: Double, apparentTemperatureMaxTime: NSTimeInterval ) {
        
        self._time = time
        self._summary = summary
        self._icon = icon
        
        self._sunriseTime = sunriseTime
        self._sunsetTime = sunsetTime
        self._moonPhase = moonPhase
        self._precipIntensity = precipIntensity
        self._precipIntensityMax = precipIntensityMax
        self._precipProbability = precipProbability
        self._temperatureMin = temperatureMin
        self._temperatureMinTime = temperatureMinTime
        self._temperatureMax = temperatureMax
        self._temperatureMaxTime = temperatureMaxTime
        self._apparentTemperatureMin = apparentTemperatureMin
        self._apparentTemperatureMinTime = apparentTemperatureMinTime
        self._apparentTemperatureMax = apparentTemperatureMax
        self._apparentTemperatureMaxTime = apparentTemperatureMaxTime
        
        self._dewPoint = dewPoint
        self._humidity = humidity
        self._windSpeed = windSpeed
        self._windBearing = windBearing
        
        self._cloudCover = cloudCover
        self._pressure = pressure
        self._ozone = ozone
        
    }
    //test
    init(time: NSTimeInterval, summary: String, icon: String, precipIntensity: Double, precipProbability: Double, dewPoint: Double, humidity: Double, windSpeed: Double, windBearing: Double, visibility: Double, cloudCover: Double, pressure: Double, ozone: Double) {
        self._time = time
        self._summary = summary
        self._icon = icon
        self._precipIntensity = precipIntensity
        self._precipProbability = precipProbability
        self._dewPoint = dewPoint
        self._humidity = humidity
        self._windSpeed = windSpeed
        self._windBearing = windBearing
        self._visibility = visibility
        self._cloudCover = cloudCover
        self._pressure = pressure
        self._ozone = ozone
    }
    
    func convertFtoC(temp: Double) -> Double {
        return round(((temp  -  32)  *  5/9) * 100) / 100
    }

}