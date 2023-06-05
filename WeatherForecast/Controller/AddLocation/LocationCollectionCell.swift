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
            locationNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            locationNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            locationNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            locationNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // separatorView
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)            
        ])
    }
}
