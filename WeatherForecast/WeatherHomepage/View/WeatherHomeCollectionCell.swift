//
//  WeatherHomeCollectionCell.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23°.
//

import UIKit

class WeatherHomeCollectionCell: UICollectionViewCell {
    
    static let identifire = "WeatherHomeCollectionCell"
    
    lazy var currentTemparatureLocationLabel = UILabel()
    lazy var weatherIconImageView = UIImageView()
    lazy var currentTemparatureLabel = UILabel()
    lazy var currentTemparatureTypeLabel = UILabel()
    
    lazy var upcomingWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.itemSize = .zero
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var moreButton = UIButton()
    
    var weatherHomeViewModel = WeatherHomeViewModel()
    var upcomingWeatherHomeViewModel = [UpcomingWeatherHomeViewModel]()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        
        configureViews()
        addSubviews()
        activateConstraint()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(data: WeatherHomeViewModel){
        
        weatherHomeViewModel = data
        
        currentTemparatureLocationLabel.text = data.locationName
        weatherIconImageView.image = UIImage(named: data.image ?? "icon_default")
        currentTemparatureLabel.text = data.temparature
        currentTemparatureTypeLabel.text = data.temparatureType

        upcomingWeatherHomeViewModel = data.upcomingWeather ?? upcomingWeatherHomeViewModel
    }
    
    func configureViews() {
        currentTemparatureLocationLabel.text = "Dhaka, Bangladesh"
        currentTemparatureLocationLabel.numberOfLines = 0
        currentTemparatureLocationLabel.textColor = .white
        currentTemparatureLocationLabel.textAlignment = .center
        currentTemparatureLocationLabel.font = UIFont.robotoSemiBoldFont(ofSize: 18)
        
        weatherIconImageView.image = UIImage(named: "icon_default")
        weatherIconImageView.contentMode = .scaleAspectFit
        
        currentTemparatureLabel.text = "37°"
        currentTemparatureLabel.textColor = .white
        currentTemparatureLabel.font = UIFont.robotoSemiBoldFont(ofSize: 80)
        
        currentTemparatureTypeLabel.text = "rainy"
        currentTemparatureTypeLabel.numberOfLines = 0
        currentTemparatureTypeLabel.textColor = .white
        currentTemparatureTypeLabel.textAlignment = .left
        currentTemparatureTypeLabel.font = UIFont.poppinsRegularFont(ofSize: 14)
        
        upcomingWeatherCollectionView.dataSource = self
        upcomingWeatherCollectionView.delegate = self
        upcomingWeatherCollectionView.isUserInteractionEnabled = false
        upcomingWeatherCollectionView.register(WeatherHomeUpcomingCollectionCell.self, forCellWithReuseIdentifier: WeatherHomeUpcomingCollectionCell.identifire)
        
        moreButton.setTitle("More >", for: .normal)
        moreButton.titleLabel?.font = UIFont.robotoSemiBoldFont(ofSize: 14)
        moreButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func addSubviews() {
        contentView.addSubview(currentTemparatureLocationLabel)
        currentTemparatureLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(weatherIconImageView)
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(currentTemparatureLabel)
        currentTemparatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(currentTemparatureTypeLabel)
        currentTemparatureTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(upcomingWeatherCollectionView)
        upcomingWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            
            // currentTemparatureLocationLabel
            currentTemparatureLocationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Utils.getSafeAreaHeight(includingNavigationBar: false)),
            currentTemparatureLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            currentTemparatureLocationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            currentTemparatureLocationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // weatherIconImageView
            weatherIconImageView.topAnchor.constraint(equalTo: currentTemparatureLocationLabel.bottomAnchor),
            weatherIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weatherIconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            weatherIconImageView.bottomAnchor.constraint(equalTo: currentTemparatureLabel.topAnchor),
            
            // currentTemparatureLabel
            currentTemparatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentTemparatureLabel.bottomAnchor.constraint(equalTo: upcomingWeatherCollectionView.topAnchor),
            currentTemparatureLabel.heightAnchor.constraint(equalToConstant: 90),
            
            // currentTemparatureTypeLabel
            currentTemparatureTypeLabel.leadingAnchor.constraint(equalTo: currentTemparatureLabel.trailingAnchor, constant: -5),
            currentTemparatureTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            currentTemparatureTypeLabel.bottomAnchor.constraint(equalTo: currentTemparatureLabel.bottomAnchor, constant: -12),
            
            // upcomingWeatherTableView
            upcomingWeatherCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            upcomingWeatherCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            upcomingWeatherCollectionView.bottomAnchor.constraint(equalTo: moreButton.topAnchor),
            upcomingWeatherCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            // moreButton
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            moreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            moreButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

extension WeatherHomeCollectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingWeatherHomeViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherHomeUpcomingCollectionCell.identifire, for: indexPath) as! WeatherHomeUpcomingCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: upcomingWeatherCollectionView.bounds.width, height: upcomingWeatherCollectionView.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
