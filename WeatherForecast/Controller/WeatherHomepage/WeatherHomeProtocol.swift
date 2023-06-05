//
//  WeatherHomeProtocol.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//


import UIKit

// MARK: - View To Presenter
protocol ViewToPresenterWeatherHomeProtocol {
    var view: PresenterToViewWeatherHomeProtocol? {get set}
    var interactor: PresenterToInteractorWeatherHomeProtocol? {get set}
    var router: PresenterToRouterWeatherHomeProtocol? {get set}
    
    func viewDidLoad()
    func refreshData()
    
    func locationButtonAction()
    func settingsButtonAction()
    func openSettings()
    
    func numberOfItemsInSection() -> Int
    func setCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func setCellSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

// MARK: - Presenter To View
protocol PresenterToViewWeatherHomeProtocol {
    func onFetchLocationSuccess()
    func onFetchLocationFailed(error: String)
    
    func showActivity()
    func hideActivity()
}

// MARK: - Presenter To Interactor
protocol PresenterToInteractorWeatherHomeProtocol {
    var presenter: InteractorToPresenterWeatherHomeProtocol? {get set}
    func fetchLocation()
    
    func fetchWeatherByLocation(name: String, lat: Double, long: Double)
}

// MARK: - Interactor To Presenter
protocol InteractorToPresenterWeatherHomeProtocol {
    func fetchLocationSuccess(data: [LocationModel])
    func fetchLocationFailure(error: String)
    
    func fetchWeatherByLocationSuccess(data: WeatherHomeViewModel)
    func fetchWeatherByLocationFailure(error: String)
}

// MARK: - Presenter To Router
protocol PresenterToRouterWeatherHomeProtocol {
    static func createModule() -> UINavigationController?
    func pushToSetting(on view: PresenterToViewWeatherHomeProtocol?)
    func pushToAddLocation(on view: PresenterToViewWeatherHomeProtocol?)
    func openSettings()
}
