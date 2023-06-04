//
//  WeatherHomePresenter.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//

import UIKit

class WeatherHomePresenter: ViewToPresenterWeatherHomeProtocol {
   
    var locationModel = [LocationModel]()
    
    var weatherHomeViewModel = [WeatherHomeViewModel]()
    
    var view: PresenterToViewWeatherHomeProtocol?
    
    var interactor: PresenterToInteractorWeatherHomeProtocol?
    
    var router: PresenterToRouterWeatherHomeProtocol?
    
    func viewDidLoad() {
        
        locationModel.removeAll()
        weatherHomeViewModel.removeAll()
        
        view?.showActivity()
        interactor?.fetchLocation()
    }
    
    func refreshData() {
        viewDidLoad()
    }
    
    func locationButtonAction() {
        print(#function)
    }
    
    func settingsButtonAction() {
        router?.pushToSetting(on: view)
    }
    
    func numberOfItemsInSection() -> Int {
        return weatherHomeViewModel.count
    }
    
    func setCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHomeCollectionCell.identifire, for: indexPath) as? WeatherHomeCollectionCell
        cell?.weatherHomePresenter = self
        cell?.bindData(data: weatherHomeViewModel[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func setCellSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension WeatherHomePresenter: InteractorToPresenterWeatherHomeProtocol {
    
    func fetchCurrentWeatherSuccess(data: WeatherHomeModel) {
        print(#function)
    }
    
    func fetchCurrentWeatherFailure(error: String) {
        print(#function)
    }
    
    
    func fetchWeatherByLocationSuccess(data: WeatherHomeModel) {
        print(#function)
        
        
        var locationName = (data.city?.name ?? "") + ", " + (data.city?.country ?? "")
        var image = Asset.CLOUDY
        var temparature = "32"
        var temparatureType = "rainy"
        var upcomingWeatherHomeViewModel = [UpcomingWeatherHomeViewModel]()
        
        let weatherList = data.list ?? [WeatherHomeListModel]()
        
        // Getting All Day Name From Data
        
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
            
            if rainCount > sunCount {
                icon = Asset.RAIN
            }
            
            if cloudCount > sunCount {
                icon = Asset.CLOUD
            }
            
            upcomingWeatherHomeViewModel.append(UpcomingWeatherHomeViewModel(dayName: weather.dayName ,
                                                                             minTemparature: Utils.getTemparatureValue(data: minTem) + "°",
                                                                             maxTemparature: Utils.getTemparatureValue(data: minTem) + "°",
                                                                             icon: icon))
            minTem = 500.0
            maxTem = 0
            sunCount = 0
            rainCount = 0
            cloudCount = 0
            icon = ""
        }
        
        interactor?.fetchCurrentWeather(lat: <#T##Double#>, long: <#T##Double#>)
        
        weatherHomeViewModel.append(WeatherHomeViewModel(locationName: locationName,
                                                         image: image,
                                                         temparature: temparature,
                                                         temparatureType: temparatureType,
                                                         upcomingWeather: upcomingWeatherHomeViewModel ))
        
        view?.onFetchLocationSuccess()
    }
    
    func fetchWeatherByLocationFailure(error: String) {
        print(#function)
    }
    
    func fetchLocationSuccess(data: [LocationModel]) {
        
        locationModel.removeAll()
        
        DispatchQueue.main.async { [self] in
            locationModel = data
            
            print("fetchLocationSuccess : \(UserDefaults.getCurrentLocation())")
            
            for item in locationModel {
                DispatchQueue.main.async {
                    self.interactor?.fetchWeatherByLocation(lat: item.latitude ?? 0.0, long: item.longitude ?? 0.0)
                }
            }
            
            view?.onFetchLocationSuccess()
            view?.hideActivity()
        }
    }
    
    func fetchLocationFailure(error: String) {
        DispatchQueue.main.async { [self] in
            view?.onFetchLocationFailed(error: error)
            view?.hideActivity()
        }
    }
}
