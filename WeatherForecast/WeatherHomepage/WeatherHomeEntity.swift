//
//  WeatherHomeEntity.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//

import UIKit

struct LocationModel: Codable {
    var name: String!
    var latitude: Double!
    var longitude: Double!
}

struct WeatherHomeViewModel: Codable {
    var locationName: String?
    var image: String?
    var temparature: String?
    var temparatureType:String?
    var upcomingWeather: [UpcomingWeatherHomeViewModel]?
}

struct UpcomingWeatherHomeViewModel: Codable {
    var dayName: String?
    var temparature: String?
    var temparatureType:String?
}



// API Data Response Model
struct WeatherHomeModel: Codable {
    var cod: String?
    var message: Double?
    var cnt: Double?
    var list: [WeatherHomeListModel]?
    var city: WeatherHomeCityModel?
}

struct WeatherHomeCityModel: Codable {
    var id: Double?
    var name: String?
    var coord: CoordinatorModel?
    var country: String?
    var population: Double?
    var timezone: Double?
    var sunrise: Double?
    var sunset: Double?
}

struct CoordinatorModel: Codable {
    var lat: Double?
    var lon: Double?
}

struct WeatherHomeListModel: Codable {
    var dt: Double?
    var main: MainClassModel?
    var weather: [WeatherModel]?
    var clouds: CloudsModel?
    var wind: WindModel?
    var visibility: Double?
    var pop: Double?
    var sys: SysModel
    var dt_txt: String?
}

struct CloudsModel: Codable {
    var all: Double?
}

struct MainClassModel: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var sea_level: Double?
    var grnd_level: Double?
    var humidity: Double?
    var temp_kf: Double?
}

struct SysModel: Codable {
    let pod: String?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

struct WeatherModel: Codable {
    var id: Double?
    var main: String?
    var description: String?
    var icon: String?
}

struct WindModel: Codable {
    var speed: Double?
    var deg: Double?
    var gust: Double?
}

