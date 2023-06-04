//
//  UserDefaults.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import Foundation


enum EnumTemparatureType: String{
    case CELSIUS
    case FAHRENHEIT
}


extension UserDefaults {
    
    static var ConstantUserCurrentLocationDefaultsKey = "ConstantUserCurrentLocationDefaultsKey"
    static var ConstantAddedLocationUserDefaultsKey = "ConstantAddedLocationUserDefaultsKey"
    static var ConstantTemparatureUserDefaultsKey = "ConstantTemparatureUserDefaultsKey"
    static var ConstantDefaultLocation = "ConstantDefaultLocation"
    
    
    static func storeCurrentLocation(data: LocationModel) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: ConstantUserCurrentLocationDefaultsKey)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    static func getCurrentLocation() -> LocationModel {
        
        var locationData = LocationModel()

        if let localDataString = UserDefaults.standard.data(forKey: ConstantUserCurrentLocationDefaultsKey) {
            do {
                let decoder = JSONDecoder()
                locationData = try decoder.decode(LocationModel.self, from: localDataString)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return locationData
    }
    
    
    // MARK: -  For Keeping Locations
    static func storeLocationData(data: LocationModel) -> Bool {
        var currentData = UserDefaults.getLocationData()
        var canAdd = true
        for item in currentData {
            if (item.latitude == data.latitude) && (item.longitude == data.longitude) {
                canAdd = false
            }
        }
        if canAdd {
            do {
                currentData.append(data)
                let encoder = JSONEncoder()
                let data = try encoder.encode(currentData)
                UserDefaults.standard.set(data, forKey: ConstantAddedLocationUserDefaultsKey)
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
        return canAdd
    }

    static func getLocationData() -> [LocationModel] {
        
        var locationData = [LocationModel]()

        if let localDataString = UserDefaults.standard.data(forKey: ConstantAddedLocationUserDefaultsKey) {
            do {
                let decoder = JSONDecoder()
                locationData = try decoder.decode([LocationModel].self, from: localDataString)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return locationData
    }
    
    
    // MARK: - For Keeing String data 
    
    static func storeStringData(data: String, key: String){
        UserDefaults.standard.set(data, forKey: key)
    }

    static func getStringData(key: String) -> String {
        if let storedString = UserDefaults.standard.string(forKey: key) {
            return storedString
        } else {
            return ""
        }
    }
}
