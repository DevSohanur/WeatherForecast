//
//  LocationCollectionCell.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit

class LocationCollectionCell: UICollectionViewCell {
    
    static let identifire = "LocationCollectionCell"
    
    lazy var locationNameLabel = UILabel()
    lazy var separatorView = UIView()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        
        configureViews()
        addSubviews()
        activateConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configureViews() {
        locationNameLabel.text = "Today"
        locationNameLabel.textColor = .black
        locationNameLabel.textAlignment = .left
        locationNameLabel.font = UIFont.poppinsRegularFont(ofSize: 14)
        
        separatorView.backgroundColor = .lightGray
    }
    
    func addSubviews() {
        contentView.addSubview(locationNameLabel)
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            
            // locationNameLabel
            locationNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            locationNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            // separatorView
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            
            
        ])
    }
}
