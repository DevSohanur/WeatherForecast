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
        view?.showActivity()
        interactor?.fetchLocation()
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
    
    func fetchWeatherByLocationSuccess(data: WeatherHomeModel) {
        print(#function)
        
        
        var locationName = (data.city?.name ?? "") + ", " + (data.city?.country ?? "")
        var image = "icon_sunny"
        var temparature = ""
        var temparatureType = ""
        var upcomingWeatherHomeViewModel = [UpcomingWeatherHomeViewModel(dayName: "Today",
                                                                         temparature: "27/35",
                                                                         icon: "")]        
        
        
        
        
        weatherHomeViewModel.append(WeatherHomeViewModel(locationName: locationName,
                                                         image: image,
                                                         temparature: temparature,
                                                         temparatureType: temparatureType,
                                                         upcomingWeather: upcomingWeatherHomeViewModel))
        
        view?.onFetchLocationSuccess()
    }
    
    func fetchWeatherByLocationFailure(error: String) {
        print(#function)
    }
    
    func fetchLocationSuccess(data: [LocationModel]) {
        DispatchQueue.main.async { [self] in
            locationModel = data
            
            print("fetchLocationSuccess : \(UserDefaults.getCurrentLocation())")
            
            for item in locationModel {
                DispatchQueue.main.async {
                    interactor?.fetchWeatherByLocation(lat: item.latitude ?? 0.0, long: item.longitude ?? 0.0)
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
