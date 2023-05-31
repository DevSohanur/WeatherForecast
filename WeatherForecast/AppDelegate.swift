//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 31/5/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let weatherRouter = WeatherRouter.start()
        let initialVC = weatherRouter.entry
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

