//
//  UIFont.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//

import UIKit

extension UIFont {
    
    static func poppinsRegularFont(ofSize fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Regular", size: fontSize)
    }
    
    static func robotoSemiBoldFont(ofSize fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Medium", size: fontSize)
    }
}
