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
}
