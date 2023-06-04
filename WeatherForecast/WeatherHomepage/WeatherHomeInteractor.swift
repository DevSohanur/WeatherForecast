//
//  WeatherHomeInteractor.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//


import Foundation

class WeatherHomeInteractor: PresenterToInteractorWeatherHomeProtocol{
    
    var presenter: InteractorToPresenterWeatherHomeProtocol?
    
    func fetchLocation() {
        
        var location = [LocationModel]()
        location.removeAll()
        location.append(UserDefaults.getCurrentLocation())
        location.append(contentsOf: UserDefaults.getLocationData())
        
        presenter?.fetchLocationSuccess(data: location)
    }
    
    func fetchWeatherByLocation(lat: Double, long: Double) {
        let parameter: [String: String] = [Constant.APP_ID_KEY : Constant.OPEN_WEATHER_API_KEY,
                                        Constant.LAT_KEY : String(describing: lat),
                                        Constant.LON_KEY : String(describing: long)]
        
        NetworkService.RestApiRequest(urlString: Constant.FORECAST_WEATHER_API_URL,
                                  queryParameters: parameter){ (result: Result<WeatherHomeModel, Error>) in
            switch result {
            case .success(let response):
                print("Success For Lat :\(lat) Long : \(long) : \(response)")
                self.presenter?.fetchWeatherByLocationSuccess(data: response)
                
            case .failure(let error):
                print("Failed \(error)")
                
                let err = "\(error)"
                
                self.presenter?.fetchWeatherByLocationFailure(error: err)
            }
        }
    }
    
    func fetchCurrentWeather(lat: Double, long: Double) -> WeatherHomeModel {
        let parameter: [String: String] = [Constant.APP_ID_KEY : Constant.OPEN_WEATHER_API_KEY,
                                        Constant.LAT_KEY : String(describing: lat),
                                        Constant.LON_KEY : String(describing: long)]
        
        NetworkService.RestApiRequest(urlString: Constant.CURRENT_WEATHER_API_URL,
                                  queryParameters: parameter){ (result: Result<WeatherHomeModel, Error>) in
            switch result {
            case .success(let response):
                print("Success For Lat :\(lat) Long : \(long) : \(response)")
                
            case .failure(let error):
                print("Failed \(error)")
                
                let err = "\(error)"
                
//                self.presenter?.fetchWeatherByLocationFailure(error: err)
            }
        }
        
    }
    
    func fetchCurrentWeather(lat: Double, long: Double) {
        let parameter: [String: String] = [Constant.APP_ID_KEY : Constant.OPEN_WEATHER_API_KEY,
                                        Constant.LAT_KEY : String(describing: lat),
                                        Constant.LON_KEY : String(describing: long)]
        
        NetworkService.RestApiRequest(urlString: Constant.CURRENT_WEATHER_API_URL,
                                  queryParameters: parameter){ (result: Result<WeatherHomeModel, Error>) in
            switch result {
            case .success(let response):
                print("Success For Lat :\(lat) Long : \(long) : \(response)")
                self.presenter?.fetchWeatherByLocationSuccess(data: response)
                
            case .failure(let error):
                print("Failed \(error)")
                
                let err = "\(error)"
                
                self.presenter?.fetchWeatherByLocationFailure(error: err)
            }
        }
    }
}
