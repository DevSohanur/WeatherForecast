//
//  UIViewController.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 4/6/23.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert,animated: true)
    }
}
