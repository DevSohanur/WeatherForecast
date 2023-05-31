//
//  WeatherInteractor.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 31/5/23.
//

import Foundation

// Object
// Protocol
// Ref to Presenter

protocol AnyWeatherInteractor{
    var presenter: AnyWeatherPresenter? { get set }
    
    func getWeather()
}

class WeatherInteractor: AnyWeatherInteractor {
    
    var presenter: AnyWeatherPresenter?
    
    func getWeather() {
        
    }
}
