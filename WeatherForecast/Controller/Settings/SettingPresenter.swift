//
//  SettingPresenter.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit

class SettingPresenter: ViewToPresenterSettingProtocol {
    
    var temparatureUnitList = [String]()
    var locationList = [String]()
    
    var view: PresenterToViewSettingProtocol?
    
    var interactor: PresenterToInteractorSettingProtocol?
    
    var router: PresenterToRouterSettingProtocol?
    
    func viewDidLoad() {
        view?.showActivity()
        interactor?.fetchLocation()
        interactor?.fetchTemparatureUnit()
    }
    
    func temparatureNumberOfItemsInSection() -> Int {
        return temparatureUnitList.count
    }
    
    func temparatureCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionCell.identifire, for: indexPath) as! SettingCollectionCell
        cell.bindData(data: temparatureUnitList[indexPath.row])
        return cell
    }
    
    func locationNumberOfItemsInSection() -> Int {
        return locationList.count
    }
    
    func locationCellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionCell.identifire, for: indexPath) as! SettingCollectionCell
        cell.bindData(data: locationList[indexPath.row])
        return cell
    }
    
    func temparatureDidSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.updateTemparatureUnit(data: temparatureUnitList[indexPath.row])
    }
    
    func locationDidSelectItemAt(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.updateLocation(data: locationList[indexPath.row])
    }
    
    func sizeForItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 51)
    }
}

extension SettingPresenter: InteractorToPresenterSettingProtocol {
    
    func fetchTemparatureUnitSuccess(data: [String]) {
        
        DispatchQueue.main.async { [self] in
            temparatureUnitList = data
            
            view?.hideActivity()
            view?.onFetchTemparatureUnitSuccess(data: data)
        }
    }
    
    func fetchLocationSuccess(data: [String]) {
        
        DispatchQueue.main.async { [self] in
            locationList = data
            
            view?.hideActivity()
            view?.onFetchLocationSuccess(data: data)
        }
    }
}
