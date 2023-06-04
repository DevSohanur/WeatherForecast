////
////  WeatherHomePresenter.swift
////  WeatherForecast
////
////  Created by Sohanur Rahman on 2/6/23.
////
//
//import UIKit
//
//class WeatherHomePresenter: ViewToPresenterWeatherHomeProtocol {
//   
//    var weatherHomeViewModel = [WeatherHomeViewModel]()
//    
//    var view: PresenterToViewWeatherHomeProtocol?
//    
//    var interactor: PresenterToInteractorWeatherHomeProtocol?
//    
//    var router: PresenterToRouterWeatherHomeProtocol?
//    
//    func viewDidLoad() {
//        view?.showActivity()
//        interactor?.fetchWeatherInformation(latitude: 37.785834, longitude: -122.406417)
//    }
//    
//    func refresh() {
//        interactor?.fetchWeatherInformation(latitude: 37.785834, longitude: -122.406417)
//    }
//    
//    func settingsButtonAction() {
//        router?.pushToSetting(on: view)
//    }
//    
//    func numberOfItemsInSection() -> Int {
//        return weatherHomeViewModel.count
//    }
//    
//    func setCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHomeCollectionCell.identifire, for: indexPath) as? WeatherHomeCollectionCell
//        cell?.bindData(data: weatherHomeViewModel[indexPath.row])
//        return cell ?? UICollectionViewCell()
//    }
//    
//    func setCellSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
//    }
//    
//    func minimumLineSpacingForSectionAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//        return 0
//    }
//    
//    func minimumInteritemSpacingForSectionAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//
//extension WeatherHomePresenter: InteractorToPresenterWeatherHomeProtocol {
//    
//    func fetchWeatherInformationSuccess(data: WeatherHomeModel) {
//        
//        
//        
//        
//        self.weatherHomeViewModel = [WeatherHomeViewModel(locationName: data.city?.name ?? "")]
//        
////        weatherHomeViewModel = [WeatherHomeViewModel(locationName: "Dhaka",
////                                          image: "icon_sunny",
////                                          temparature: "32",
////                                          temparatureType: "Rainy",
////                                          upcomingWeather: [UpcomingWeatherHomeViewModel(dayName: "Today", temparature: "23/32", temparatureType: "Rainy"),
////                                                            UpcomingWeatherHomeViewModel(dayName: "Tomorrow", temparature: "23/32", temparatureType: "Rainy"),
////                                                            UpcomingWeatherHomeViewModel(dayName: "Next Day", temparature: "23/32", temparatureType: "Rainy"),])
////                            ]
//        
//        
//        view?.hideActivity()
//        view?.onFetchWeatherInformationSuccess()
//    }
//    
//    func fetchWeatherInformationFailure(error: String) {
//        
////        weatherHomeViewModel = [WeatherHomeViewModel(locationName: "Dhaka",
////                                          image: "icon_sunny",
////                                          temparature: "32",
////                                          temparatureType: "Rainy",
////                                          upcomingWeather: [UpcomingWeatherHomeViewModel(dayName: "Today", temparature: "23/32", temparatureType: "Rainy"),
////                                                            UpcomingWeatherHomeViewModel(dayName: "Tomorrow", temparature: "23/32", temparatureType: "Rainy"),
////                                                            UpcomingWeatherHomeViewModel(dayName: "Next Day", temparature: "23/32", temparatureType: "Rainy"),])
////                            ]
//        
//        view?.hideActivity()
//        view?.onFetchWeatherInformationFailed(error: error)
//    }
//}
//
