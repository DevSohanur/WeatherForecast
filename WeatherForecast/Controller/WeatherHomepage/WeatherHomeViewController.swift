//
//  WeatherHomeViewController.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 2/6/23.
//

import UIKit
import CoreLocation

class WeatherHomeViewController: UIViewController {
    
    var presenter: (ViewToPresenterWeatherHomeProtocol &
                    InteractorToPresenterWeatherHomeProtocol)?
    
    let locationManager = CLLocationManager()
    
    lazy var chooseLocationButton = UIButton()
    lazy var settingsButton = UIButton()
    
    lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.itemSize = .zero
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var errorLabel = UILabel()
    lazy var refreshButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.navigationController?.navigationBar.isHidden = true
        
        locationManager.delegate = self
        checkLocationAuthorization()
        
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewDidLoad()
    }
    
    @objc func locationButtonAction() {
//        self.navigationController?.pushViewController(AddLocationViewController(), animated: true)
        presenter?.locationButtonAction()
    }
    
    @objc func refreshButtonAction() {
        presenter?.viewDidLoad()
    }
    
    @objc func settingsButtonAction() {
        presenter?.settingsButtonAction()
    }
    
    func initView() {
        
        errorLabel.text = ""
        errorLabel.isHidden = true
        errorLabel.textAlignment = .center
        errorLabel.textColor = .white
        errorLabel.font = UIFont.poppinsRegularFont(ofSize: 14)
        
        refreshButton.isHidden = true
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.titleLabel?.font = UIFont.robotoSemiBoldFont(ofSize: 14)
        refreshButton.setTitleColor(UIColor.white, for: .normal)
        refreshButton.backgroundColor = .black
        refreshButton.addTarget(self, action: #selector(refreshButtonAction), for: .touchUpInside)

        chooseLocationButton.setImage(UIImage(named: "icon_map"), for: .normal)
        chooseLocationButton.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)

        settingsButton.setImage(UIImage(named: "icon_settings"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)

        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.isPagingEnabled = true
        weatherCollectionView.contentInsetAdjustmentBehavior = .never
        weatherCollectionView.register(WeatherHomeCollectionCell.self, forCellWithReuseIdentifier: WeatherHomeCollectionCell.identifire)
        
        
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(weatherCollectionView)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(chooseLocationButton)
        chooseLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            refreshButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor,constant:  10),
            refreshButton.widthAnchor.constraint(equalToConstant: 100),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // set weatherCollectionView edges to superview
            weatherCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            chooseLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chooseLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chooseLocationButton.widthAnchor.constraint(equalToConstant: 40),
            chooseLocationButton.heightAnchor.constraint(equalToConstant: 40),
            
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension WeatherHomeViewController: PresenterToViewWeatherHomeProtocol {
    
    func onFetchLocationSuccess() {
        DispatchQueue.main.async {
            self.weatherCollectionView.isHidden = false
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
            self.refreshButton.isHidden = true
            
            self.weatherCollectionView.reloadData()
            self.hideActivity()
        }
    }
    
    func onFetchLocationFailed(error: String) {
        print(#function)
        DispatchQueue.main.async {
            
            self.errorLabel.text = error
            self.errorLabel.isHidden = false
            self.refreshButton.isHidden = false
            
            self.weatherCollectionView.isHidden = true
            self.hideActivity()
        }
    }
    
    func showActivity() {
        print(#function)
        DispatchQueue.main.async {
            self.view.showLoadingView()
        }
    }
    
    func hideActivity() {
        print(#function)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.view.hideLoadingView()
        })
    }
}

extension WeatherHomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter?.setCellForItemAt(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter?.setCellSize(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension WeatherHomeViewController: CLLocationManagerDelegate {
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location Coordinate .authorizedWhenInUse, .authorizedAlways")
            // Permission granted, start location updates
            locationManager.startUpdatingLocation()
            break
            
        case .denied, .restricted:
            print("Location Coordinate .denied, .restricted")
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.showPermissionDeniedAlert()
            })
            break
            
        case .notDetermined:
            print("Location Coordinate .notDetermined")
            locationManager.requestWhenInUseAuthorization()
            
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location Coordinate .authorizedWhenInUse, .authorizedAlways")
            // Permission granted, start location updates
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location Coordinate .denied, .restricted")
            // Permission denied, handle accordingly (e.g., show an alert)
            break
        case .notDetermined:
            print("Location Coordinate .notDetermined")
            break
        @unknown default:
            print("Location Coordinate default")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Location coordinates retrieved
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            print("Location Coordinate Latitude : \(latitude) longitude : \(longitude)")
            
            let data = UserDefaults.getCurrentLocation()
            
            
            
            if (String(format: "%.2f", (data.latitude ?? 0.0)) != String(format: "%.2f", (latitude)) ) &&
                (String(format: "%.2f", (data.longitude ?? 0.0)) != String(format: "%.2f", (longitude)) ) {
                UserDefaults.storeCurrentLocation(data: LocationModel(name: "", latitude: latitude, longitude: longitude))
                
                DispatchQueue.main.async {
                    self.presenter?.viewDidLoad()
                }
            }
            else{
                print("Location Not Updated")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Coordinate Failed To Get ")
    }
    
    func showPermissionDeniedAlert() {
        let alert = UIAlertController( title: "Location Access Denied",
                                       message: "Please enable location access in Settings to get current weather information.",
                                       preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            self.openAppSettings()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}

