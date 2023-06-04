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
        
        //Setting Root View Controller Using Router
        let weatherRouter = WeatherHomeRouter.createModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = weatherRouter
        window?.makeKeyAndVisible()
        return true
    }
}
