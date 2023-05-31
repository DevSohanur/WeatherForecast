//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 31/5/23.
//

import Foundation
import UIKit

// View Controller
// Protocol
// Reference Presenter

protocol AnyWeatherView{
    var presenter: AnyWeatherPresenter? { get set }
    
    func update(with weather: [WeatherModel])
    func update(with error: String)
}


class WeatherViewController: UIViewController, AnyWeatherView {
    
    var presenter: AnyWeatherPresenter?
    
    private let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Hello, Welcome to Viper Architechture"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(label)
        label.frame = view.bounds
    }
    
    func update(with weather: [WeatherModel]) {
        print("")
    }
    
    func update(with error: String) {
        print("")
    }
}
