//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 31/5/23.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var locationManager: CLLocationManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setting Location Permission From User
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        // Setting Root View Controller Using Router
        let weatherRouter = WeatherHomeRouter.createModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = weatherRouter
        window?.makeKeyAndVisible()
        
        return true
    }
}


extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location-related errors
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("Permission Granted")
            locationManager?.startUpdatingLocation()
        }
        else{
            print("Permission Denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Update Locations Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("Update Locations No placemark found.")
                return
            }
            
            // Access the location information
            if let city = placemark.locality, let state = placemark.administrativeArea {
                
                var currentLocationData = UserDefaults.getLocationData()
                
                var hasDefaultAddress = false
                var locationPosition = -1
                
                if currentLocationData.count != 0{
                    for index in 0...currentLocationData.count - 1 {
                        if currentLocationData[index].source == EnumLocationSource.LOCATION {
                            locationPosition = index
                        }
                        if currentLocationData[index].isDefault == true{
                            hasDefaultAddress = true
                        }
                    }
                    
                    if locationPosition != -1{
                        currentLocationData.remove(at: locationPosition)
                    }
                    currentLocationData.insert(LocationModel(id: currentLocationData.count + 1,
                                                             name: (city + ", " + state),
                                                             latitude: location.coordinate.latitude,
                                                             longitude: location.coordinate.longitude,
                                                             isDefault: !hasDefaultAddress,
                                                             source: .LOCATION),
                                               at: locationPosition)
                    
                    UserDefaults.storeLocationData(data: currentLocationData)
                    
                    print(UserDefaults.getLocationData())
                }
                else{
                    currentLocationData.append(LocationModel(id: currentLocationData.count + 1,
                                                             name: (city + ", " + state),
                                                             latitude: location.coordinate.latitude,
                                                             longitude: location.coordinate.longitude,
                                                             isDefault: true,
                                                             source: .LOCATION))
                    
                    UserDefaults.storeLocationData(data: currentLocationData)
                    
                    print(UserDefaults.getLocationData())
                }
            } else {
                print("Update Locations Unable to retrieve location information.")
            }
        }
    }
}

