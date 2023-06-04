//
//  Utils.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//

import UIKit
import Foundation

class Utils{
    static func getSafeAreaHeight(includingNavigationBar: Bool) -> CGFloat {
        let window = UIApplication.shared.windows[0]
        let safeAreaTop = window.safeAreaInsets.top
        let safeAreaFrame = (window.bounds.height - window.safeAreaLayoutGuide.layoutFrame.size.height)
        return includingNavigationBar ? safeAreaFrame : safeAreaTop
    }
    
    static func getDateName(data: String) -> String {
        var dayName = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: data) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            let todayName = dayFormatter.string(from: Date())
            dayName = dayFormatter.string(from: date)
            dayName = (dayName.lowercased() == todayName.lowercased() ? "Today" : dayName )
        }
        return dayName
    }
    
    static func getTemparatureValue(data: Double) -> String {
        
        var tempString = ""
        
        let defaultTemparature = UserDefaults.getStringData(key: UserDefaults.ConstantTemparatureUserDefaultsKey)
        
        print("Default Temparature : \(defaultTemparature)")
        
        if defaultTemparature.isEmpty || defaultTemparature.lowercased().contains(EnumTemparatureType.CELSIUS.rawValue.lowercased())  {
            tempString = String(format: "%.1f", (data - 273.15))
        }
        else{
            tempString = String(format: "%.1f", (data - 273.15) * 9/5 + 32 )
        }
        
        return tempString
    }
}
