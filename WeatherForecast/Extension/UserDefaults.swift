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
    
    static var ConstantLocationDataUserDefaultsKey = "ConstantLocationDataUserDefaultsKey"
    static var ConstantTemparatureUserDefaultsKey = "ConstantTemparatureUserDefaultsKey"
    
    // MARK: -  For Keeping Locations
    
    static func storeLocationData(data: [LocationModel]){
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: ConstantLocationDataUserDefaultsKey)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }

    static func getLocationData() -> [LocationModel] {
        
        var locationData = [LocationModel]()

        if let localDataString = UserDefaults.standard.data(forKey: ConstantLocationDataUserDefaultsKey) {
            do {
                let decoder = JSONDecoder()
                locationData = try decoder.decode([LocationModel].self, from: localDataString)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return locationData
    }
    
    
    // MARK: - For Keeping Temparature Type
    static func storeTemparatureType(data: EnumTemparatureType){
        UserDefaults.standard.set(data.rawValue, forKey: ConstantTemparatureUserDefaultsKey)
    }

    static func getTemparatureType() -> EnumTemparatureType {
        if let storedString = UserDefaults.standard.string(forKey: ConstantTemparatureUserDefaultsKey) {
            return (storedString == EnumTemparatureType.CELSIUS.rawValue ? EnumTemparatureType.CELSIUS : EnumTemparatureType.FAHRENHEIT )
        } else {
            return .CELSIUS
        }
    }
}
