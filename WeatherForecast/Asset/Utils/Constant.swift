//
//  Constant.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import Foundation

class Constant{
    
    static let OPEN_WEATHER_API_KEY: String = "0d684dd73f98027229156f36f2b75da4"
    
    static let FORECAST_WEATHER_API_URL: String = "https://api.openweathermap.org/data/2.5/forecast"
    static let CURRENT_WEATHER_API_URL: String = "https://api.openweathermap.org/data/2.5/weather"
    
    static let LAT_KEY: String = "lat"
    static let LON_KEY: String = "lon"
    static let APP_ID_KEY: String = "appid"
}


class Asset {
    static let SUN: String = "icon_sun"
    static let CLOUD: String = "icon_cloud"
    static let RAIN: String = "icon_rain"
    
    static let SUNNY: String = "icon_sunny"
    static let RAINY: String = "icon_rainy"
    static let CLOUDY: String = "icon_cloudy"
}
