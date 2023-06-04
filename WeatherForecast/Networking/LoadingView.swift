//
//  LoadingView.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit


extension UIView {
        
    func showLoadingView() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.white
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        let label = UILabel()
        label.text = "Loading Data. \nPlease Wait..."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.poppinsRegularFont(ofSize: 14)
        
        label.frame = CGRect(x: 20,
                             y: ((self.bounds.height / 2) + 20) ,
                             width: self.bounds.width - 40,
                             height: 44)
        
        backgroundView.addSubview(label)
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
    }
    
    func hideLoadingView() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
