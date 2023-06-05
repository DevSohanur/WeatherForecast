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
        
        let defaultLocation = UserDefaults.getStringData(key: UserDefaults.ConstantDefaultLocation)
        
        var defaultIndex = 0
        
        for index in 0...location.count - 1 {
            if location[index].name == defaultLocation {
                defaultIndex = index
            }
        }
        
        if defaultIndex != 0 {
            let defaultLocation = location[defaultIndex]
            location.remove(at: defaultIndex)
            location.insert(defaultLocation, at: 0)
        }
        
        presenter?.fetchLocationSuccess(data: location)
    }
    
    
    func fetchForecastByLocation(name: String , lat: Double, long: Double, currentWeather: WeatherHomeModel) {
        let parameter: [String: String] = [Constant.APP_ID_KEY : Constant.OPEN_WEATHER_API_KEY,
                                           Constant.LAT_KEY : String(describing: lat),
                                           Constant.LON_KEY : String(describing: long)]
        
        NetworkService.RestApiRequest(urlString: Constant.FORECAST_WEATHER_API_URL,
                                      queryParameters: parameter){ (result: Result<WeatherHomeModel, Error>) in
            switch result {
                
            case .success(let data):
                
                print("Success For Weather Forecast with Lat :\(lat) Long : \(long)")
                
                // Defining Location Name
                let locationName = name.isEmpty ? ((data.city?.name ?? "") + ", " + (data.city?.country ?? "")) : name
                
                // Defining Weather Type Icon
                var currnetWeatherTypeImage = "icon_sunny"
                let status = currentWeather.weather?[0].id ?? 0.0
                if status == 800 {
                    currnetWeatherTypeImage = "icon_sunny"
                    
                }
                else if (status >= 200 && status <= 232) ||
                            (status >= 300 && status <= 321) ||
                            (status >= 500 && status <= 531){
                    currnetWeatherTypeImage = "icon_rainy"
                }
                else{
                    currnetWeatherTypeImage = "icon_cloudy"
                }
                
                
                let currentTemparature = Utils.getTemparatureValue(data: currentWeather.main?.temp ?? 0)
                let currentWeatherType = currentWeather.weather?[0].main ?? ""
                
                var upcomingWeatherHomeViewModel = [UpcomingWeatherHomeViewModel]()
                let weatherList = data.list ?? [WeatherHomeListModel]()

                // MARK: - Getting All Day Name From Data

                var weatherModel = [UpcomingWeatherHomeViewModel]()
                var dayName = ""
                for item in weatherList {
                    let weatherDayName = Utils.getDateName(data: item.dt_txt ?? "")

                    if weatherDayName != dayName {
                        weatherModel.append(UpcomingWeatherHomeViewModel(dayName: weatherDayName, minTemparature: "10", maxTemparature: "35", icon: ""))
                    }
                    dayName = weatherDayName
                }

                // Now Getting Min and Max Temparature and Weather Icon From Below Method

                var minTem = 500.0
                var maxTem = 0.0

                var sunCount = 0
                var rainCount = 0
                var cloudCount = 0
                var icon = ""

                for weather in weatherModel {

                    for item in weatherList {

                        if (Utils.getDateName(data: item.dt_txt ?? "")).lowercased() == weather.dayName?.lowercased() {

                            minTem = ( (item.main?.temp_min ?? 0.0) < minTem ? (item.main?.temp_min ?? 0.0) : minTem)
                            maxTem = ( (item.main?.temp_max ?? 0.0) > maxTem ? (item.main?.temp_max ?? 0.0) : maxTem)

                            let weatherSituation = item.weather ?? [WeatherModel]()

                            for situation in weatherSituation {
                                let status = situation.id ?? 0
                                if status == 800 {
                                    sunCount += 1
                                }
                                else if (status >= 200 && status <= 232) ||
                                            (status >= 300 && status <= 321) ||
                                            (status >= 500 && status <= 531){
                                    rainCount += 1
                                }
                                else{
                                    cloudCount += 1
                                }
                            }
                        }
                    }

                    icon = Asset.SUN
//
                    if (rainCount > sunCount) && (rainCount > cloudCount) {
                        icon = Asset.RAIN
                    }
                    else if (cloudCount > sunCount) && (cloudCount > rainCount ){
                        icon = Asset.CLOUD
                    }
                    else{
                        icon = Asset.SUN
                    }


                    upcomingWeatherHomeViewModel.append(UpcomingWeatherHomeViewModel(dayName: weather.dayName ,
                                                                                     minTemparature: Utils.getTemparatureValue(data: minTem),
                                                                                     maxTemparature: Utils.getTemparatureValue(data: minTem),
                                                                                     icon: icon))
                    minTem = 500.0
                    maxTem = 0
                    sunCount = 0
                    rainCount = 0
                    cloudCount = 0
                    icon = ""
                }


                let responseData = WeatherHomeViewModel(locationName: locationName,
                                                                 image: currnetWeatherTypeImage,
                                                                 temparature: currentTemparature,
                                                                 temparatureType: currentWeatherType,
                                                                 upcomingWeather: upcomingWeatherHomeViewModel)
                
                self.presenter?.fetchWeatherByLocationSuccess(data: responseData)
                
                
            case .failure(let error):
                print("Failed \(error)")
                
                let err = "\(error)"
                
                self.presenter?.fetchWeatherByLocationFailure(error: err)
            }
        }
        
    }
    
    func fetchWeatherByLocation(name: String , lat: Double, long: Double) {
        let parameter: [String: String] = [Constant.APP_ID_KEY : Constant.OPEN_WEATHER_API_KEY,
                                           Constant.LAT_KEY : String(describing: lat),
                                           Constant.LON_KEY : String(describing: long)]
        
        NetworkService.RestApiRequest(urlString: Constant.CURRENT_WEATHER_API_URL,
                                      queryParameters: parameter){ (result: Result<WeatherHomeModel, Error>) in
            switch result {
                
            case .success(let response):
                print("Success For Weather Current with Lat :\(lat) Long : \(long)")
                
                DispatchQueue.main.async{
                    self.fetchForecastByLocation(name: name, lat: lat, long: long, currentWeather: response)
                }
                
            case .failure(let error):
                print("Failed \(error)")
                
                let err = "\(error)"
                
                self.presenter?.fetchWeatherByLocationFailure(error: err)
            }
        }
    }
}
