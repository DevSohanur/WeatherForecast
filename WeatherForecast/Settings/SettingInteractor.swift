//
//  SettingInteractor.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import Foundation

class SettingInteractor: PresenterToInteractorSettingProtocol {
    
    var presenter: InteractorToPresenterSettingProtocol?
    
    var location: [String]?
    
    var temparatureUnit: [String]?
    
    func fetchLocation() {
        presenter?.fetchTemparatureUnitSuccess(data: ["Celsius (°C)" , "Fahrenheit (°F)"] )
    }
    
    func fetchTemparatureUnit() {
        presenter?.fetchLocationSuccess(data: UserDefaults.getLocationData().compactMap { $0.name} )
    }
    
    func updateLocation(data: String) {
        UserDefaults.storeStringData(data: data, key: UserDefaults.ConstantDefaultLocation)
        print(UserDefaults.getStringData(key: UserDefaults.ConstantDefaultLocation))
    }
    
    func updateTemparatureUnit(data: String) {
        UserDefaults.storeStringData(data: data, key: UserDefaults.ConstantTemparatureUserDefaultsKey)
        print(UserDefaults.getStringData(key: UserDefaults.ConstantTemparatureUserDefaultsKey))
    }
}
