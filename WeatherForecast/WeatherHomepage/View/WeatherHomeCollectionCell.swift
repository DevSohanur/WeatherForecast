//
//  WeatherHomeCollectionCell.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23°.
//

import UIKit

class WeatherHomeCollectionCell: UICollectionViewCell {
    
    static let identifire = "WeatherHomeCollectionCell"
    
    var weatherHomePresenter: WeatherHomePresenter!
    
    var scroll = UIScrollView(frame: .zero)
    var scrollView = UIView()
    let refreshControl = UIRefreshControl()

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
        upcomingWeatherCollectionView.reloadData()
    }
    
    func configureViews() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        scroll.contentInset = .zero
        scroll.refreshControl = refreshControl
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false

        currentTemparatureLocationLabel.text = ".."
        currentTemparatureLocationLabel.numberOfLines = 0
        currentTemparatureLocationLabel.textColor = .white
        currentTemparatureLocationLabel.textAlignment = .center
        currentTemparatureLocationLabel.font = UIFont.robotoSemiBoldFont(ofSize: 22)
        
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
        upcomingWeatherCollectionView.isScrollEnabled = false
        upcomingWeatherCollectionView.register(WeatherHomeUpcomingCollectionCell.self, forCellWithReuseIdentifier: WeatherHomeUpcomingCollectionCell.identifire)
        
        moreButton.setTitle("More >", for: .normal)
        moreButton.titleLabel?.font = UIFont.robotoSemiBoldFont(ofSize: 14)
        moreButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        weatherHomePresenter.refreshData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.refreshControl.endRefreshing()
        })
    }
    
    func addSubviews() {
        
        contentView.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(currentTemparatureLocationLabel)
        currentTemparatureLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(weatherIconImageView)
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(currentTemparatureLabel)
        currentTemparatureLabel.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(currentTemparatureTypeLabel)
        currentTemparatureTypeLabel.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(upcomingWeatherCollectionView)
        upcomingWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            
            scroll.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: scroll.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 30),
            
            // currentTemparatureLocationLabel
            currentTemparatureLocationLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Utils.getSafeAreaHeight(includingNavigationBar: false)),
            currentTemparatureLocationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 50),
            currentTemparatureLocationLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -50),
            currentTemparatureLocationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // weatherIconImageView
            weatherIconImageView.topAnchor.constraint(equalTo: currentTemparatureLocationLabel.bottomAnchor, constant: 20),
            weatherIconImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            weatherIconImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 1.5) - 40),
            
            // currentTemparatureLabel
            currentTemparatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentTemparatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 10),
            currentTemparatureLabel.heightAnchor.constraint(equalToConstant: 90),

            // currentTemparatureTypeLabel
            currentTemparatureTypeLabel.leadingAnchor.constraint(equalTo: currentTemparatureLabel.trailingAnchor),
            currentTemparatureTypeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            currentTemparatureTypeLabel.bottomAnchor.constraint(equalTo: currentTemparatureLabel.bottomAnchor, constant: -12),

            // upcomingWeatherTableView
            upcomingWeatherCollectionView.topAnchor.constraint(equalTo: currentTemparatureLabel.bottomAnchor, constant: 20),
            upcomingWeatherCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            upcomingWeatherCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            upcomingWeatherCollectionView.heightAnchor.constraint(equalToConstant: 300),

            // moreButton
            moreButton.topAnchor.constraint(equalTo: upcomingWeatherCollectionView.bottomAnchor, constant: 20),
            moreButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            moreButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
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
        cell.bindData(data: upcomingWeatherHomeViewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: upcomingWeatherCollectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.weatherHomePresenter.settingsButtonAction()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
