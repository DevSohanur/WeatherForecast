//
//  SettingProtocol.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit

// MARK: - View To Presenter
protocol ViewToPresenterSettingProtocol {
    var view: PresenterToViewSettingProtocol? {get set}
    var interactor: PresenterToInteractorSettingProtocol? {get set}
    var router: PresenterToRouterSettingProtocol? {get set}

    func viewDidLoad()
    
    func temparatureNumberOfItemsInSection() -> Int
    func temparatureCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func temparatureDidSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    func locationNumberOfItemsInSection() -> Int
    func locationCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func locationDidSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    func sizeForItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

// MARK: - Presenter To View
protocol PresenterToViewSettingProtocol {
    func onFetchLocationSuccess(data: [String])
    func onFetchTemparatureUnitSuccess(data: [String])
    
    func showActivity()
    func hideActivity()
}

// MARK: - Presenter To Interactor
protocol PresenterToInteractorSettingProtocol {
    var presenter: InteractorToPresenterSettingProtocol? {get set}
    var location: [String]? {get set}
    var temparatureUnit: [String]? {get set}
    func fetchLocation()
    func fetchTemparatureUnit()
    
    func updateLocation(data: String)
    func updateTemparatureUnit(data: String)
}

// MARK: - Interactor To Presenter
protocol InteractorToPresenterSettingProtocol {
    func fetchTemparatureUnitSuccess(data: [String])
    func fetchLocationSuccess(data: [String])
}

// MARK: - Presenter To Router
protocol PresenterToRouterSettingProtocol {
    static func createModule() -> UIViewController?
}
