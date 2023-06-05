//
//  WeatherHomeUpcomingTableCell.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//

import UIKit

class WeatherHomeUpcomingCollectionCell: UICollectionViewCell {
    
    static let identifire = "WeatherHomeUpcomingCollectionCell"
    
    lazy var weatherIconImageView = UIImageView()
    lazy var weatherDateNameLabel = UILabel()
    lazy var weatherTemparatureRangeLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        
        configureViews()
        addSubviews()
        activateConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(data: UpcomingWeatherHomeViewModel) {
        weatherIconImageView.image = UIImage(named: data.icon ?? "icon_default")
        weatherDateNameLabel.text = data.dayName ?? ""
        weatherTemparatureRangeLabel.text = "\(data.minTemparature ?? "") / \(data.maxTemparature ?? "")"
    }
        
    func configureViews() {
        
        weatherIconImageView.image = UIImage(named: "icon_default")
        weatherIconImageView.contentMode = .scaleAspectFit
        
        weatherDateNameLabel.text = "..."
        weatherDateNameLabel.textColor = .white
        weatherDateNameLabel.textAlignment = .left
        weatherDateNameLabel.font = UIFont.robotoSemiBoldFont(ofSize: 16)
        
        weatherTemparatureRangeLabel.text = "0°/0°"
        weatherTemparatureRangeLabel.textColor = .white
        weatherTemparatureRangeLabel.textAlignment = .right
        weatherTemparatureRangeLabel.font = UIFont.robotoSemiBoldFont(ofSize: 16)
    }
    
    func addSubviews() {
        contentView.addSubview(weatherIconImageView)
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(weatherDateNameLabel)
        weatherDateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(weatherTemparatureRangeLabel)
        weatherTemparatureRangeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            
            // weatherIconImageView
            weatherIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherIconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 24),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            // weatherDateNameLabel
            weatherDateNameLabel.centerYAnchor.constraint(equalTo: weatherIconImageView.centerYAnchor),
            weatherDateNameLabel.leadingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor, constant: 5),
            
            // weatherTemparatureRangeLabel
            weatherTemparatureRangeLabel.centerYAnchor.constraint(equalTo: weatherIconImageView.centerYAnchor),
            weatherTemparatureRangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
