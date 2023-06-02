//
//  UIFont.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//

import UIKit

extension UIFont {
    
    static func helveticaRegularFont(ofSize fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "HHelvetica Neue", size: fontSize)
    }
    
    static func helveticaSemiBoldFont(ofSize fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Helvetica Neue Medium", size: fontSize)
    }
    
    static func helveticaBoldFont(ofSize fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "Helvetica Neue Bold", size: fontSize)
    }
}
