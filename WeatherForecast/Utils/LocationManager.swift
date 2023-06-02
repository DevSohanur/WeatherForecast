//
//  LocationManager.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit
import CoreLocation

class LocationManager: UIViewController {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Use the user's current location
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // Do something with the latitude and longitude
        
        // Stop updating location once you have the desired location
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location request failure
    }
}

struct LocationModel: Codable {
    var id: Int?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var isDefault: Bool?
    var source: EnumLocationSource?
}

enum EnumLocationSource: String, Codable {
    case LOCATION
    case SEARCH
}
