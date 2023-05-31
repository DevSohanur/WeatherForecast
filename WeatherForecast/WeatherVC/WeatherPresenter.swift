//
//  WeatherPresenter.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 31/5/23.
//

import Foundation

// Object
// Protocol
// Reference to Interactor, Router, View

protocol AnyWeatherPresenter{
    var router: AnyWeatherRouter? { get set }
    var interactor: AnyWeatherInteractor? { get set }
    var view: AnyWeatherView? { get set }
    
    func interactorDidFetchWeather(with result: Result<[WeatherModel] , Error>)
}

class WeatherPresenter: AnyWeatherPresenter{
    
    var router: AnyWeatherRouter?
    
    var interactor: AnyWeatherInteractor?
    
    var view: AnyWeatherView?
    
    func interactorDidFetchWeather(with result: Result<[WeatherModel], Error>) {
        print("")
    }
}
