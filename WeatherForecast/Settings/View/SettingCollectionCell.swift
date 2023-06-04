//
//  SettingCollectionCell.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit

class SettingCollectionCell: UICollectionViewCell {
    
    static let identifire = "SettingCollectionCell"
    
    lazy var titleLabel = UILabel()
    lazy var selectImageView = UIImageView()
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
    
    override var isSelected: Bool {
        didSet {
            if isSelected{
                selectImageView.isHidden = false
            }
            else{
                selectImageView.isHidden = true
            }
        }
    }
    
    func bindData(data: String) {
        titleLabel.text = data
    }
    
    func configureViews() {
        titleLabel.text = "Farenheit"
        titleLabel.textColor = UIColor.titleColor
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.poppinsRegularFont(ofSize: 14)
        
        selectImageView.image = UIImage(named: "icon_check_line")
        selectImageView.contentMode = .scaleAspectFit
        selectImageView.isHidden = true
        
        separatorView.backgroundColor = .lightGray.withAlphaComponent(0.5)
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(selectImageView)
        selectImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Select Image View
            selectImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            selectImageView.widthAnchor.constraint(equalToConstant: 20),
            selectImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Select Image View
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
