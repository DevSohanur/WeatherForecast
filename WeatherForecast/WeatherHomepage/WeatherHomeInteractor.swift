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
    
    
//    var weather: [WeatherModel]?
//    
//    
//    func fetchWeatherInformation(latitude: Double, longitude: Double) {
//        let parameter: [String: String] = [Constant.APP_ID_KEY : Constant.OPEN_WEATHER_API_KEY,
//                                        Constant.LAT_KEY : "37.7858",
//                                        Constant.LON_KEY : "-122.4064"]
//        
//        NetworkService.RestApiRequest(urlString: Constant.OPEN_WEATHER_API_URL,
//                                  queryParameters: parameter){ (result: Result<WeatherHomeModel, Error>) in
//            switch result {
//            case .success(let response):
//                print("Success : \(response)")
//                self.presenter?.fetchWeatherInformationSuccess(data: response)
//                
//            case .failure(let error):
//                print("Failed \(error)")
//                self.presenter?.fetchWeatherInformationFailure(error: "Failed To Get Weather Information")
//            }
//        }
//    }
}
