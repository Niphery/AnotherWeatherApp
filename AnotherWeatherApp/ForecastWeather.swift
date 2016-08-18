//
//  ForecastWeather.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 16-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import Foundation

class ForecastWeather {
    private var _summary: String!
    private var _icon: String!
    private var _data: [Weather] = []
    
    
    var summary: String {
        return _summary
    }
    
    var icon: String {
        return _icon
    }
    
    var data: [Weather] {
        if _data.isEmpty {
            return []
        } else {
            return _data
        }
        
    }
    
    init(sumary: String, icon: String) {
        self._summary = sumary
        self._icon = icon
    }
    
    // Helpers
    func addData(weather: Weather) {
        self._data.append(weather)
    }
}