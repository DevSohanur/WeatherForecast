////
////  WeatherHomeViewController.swift
////  WeatherForecast
////
////  Created by Sohanur Rahman on 2/6/23.
////
//
//import UIKit
//
//class WeatherHomeViewController: UIViewController {
//    
//    var presenter: (ViewToPresenterWeatherHomeProtocol &
//                    InteractorToPresenterWeatherHomeProtocol)?
//    
//    lazy var chooseLocationButton = UIButton()
//    lazy var settingsButton = UIButton()
//    
//    lazy var weatherCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = .zero
//        layout.itemSize = .zero
//        layout.scrollDirection = .horizontal
//        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        return collectionView
//    }()
//    
//    lazy var errorLabel = UILabel()
//    lazy var refreshButton = UIButton()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .lightGray
//        self.navigationController?.navigationBar.isHidden = true
//        initView()
//                
//        presenter?.viewDidLoad()
//    }
//    
//    
//    @objc func locationButtonAction() {
//        let alert = UIAlertController(title: "", message: "Select your desired menu from below ", preferredStyle: .actionSheet)
//            
//        alert.addAction(UIAlertAction(title: "Update Location", style: .default) { (action) in
//            
//        })
//        
//        alert.addAction(UIAlertAction(title: "Add Location", style: .default) { (action) in
//            self.navigationController?.pushViewController(AddLocationViewController(), animated: true)
//        })
//        
//        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive) { (action) in
//            
//        })
//                
//        present(alert, animated: true, completion: nil)
//    }
//    
//    @objc func settingsButtonAction() {
//        presenter?.settingsButtonAction()
//    }
//    
//    func initView() {
//        
//        chooseLocationButton.setImage(UIImage(named: "icon_map"), for: .normal)
//        chooseLocationButton.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)
//
//        settingsButton.setImage(UIImage(named: "icon_settings"), for: .normal)
//        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
//
//        weatherCollectionView.dataSource = self
//        weatherCollectionView.delegate = self
//        weatherCollectionView.isPagingEnabled = true
////        weatherCollectionView.contentInset = .zero
//        weatherCollectionView.backgroundColor = UIColor.sunnyBackground
//        weatherCollectionView.register(WeatherHomeCollectionCell.self, forCellWithReuseIdentifier: WeatherHomeCollectionCell.identifire)
//        
//        view.addSubview(weatherCollectionView)
//        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(chooseLocationButton)
//        chooseLocationButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(settingsButton)
//        settingsButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Set static constraints
//        NSLayoutConstraint.activate([
//            // set dimmedView edges to superview
//            weatherCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            weatherCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            
//            chooseLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            chooseLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            chooseLocationButton.widthAnchor.constraint(equalToConstant: 40),
//            chooseLocationButton.heightAnchor.constraint(equalToConstant: 40),
//            
//            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            settingsButton.widthAnchor.constraint(equalToConstant: 40),
//            settingsButton.heightAnchor.constraint(equalToConstant: 40),
//        ])
//    }
//}
//
//extension WeatherHomeViewController: PresenterToViewWeatherHomeProtocol {
//    
//    func onFetchWeatherInformationSuccess() {
//        
//        DispatchQueue.main.async {
//            self.weatherCollectionView.reloadData()
//        }
//    }
//    
//    func onFetchWeatherInformationFailed(error: String) {
//        
//        DispatchQueue.main.async {
//            self.weatherCollectionView.reloadData()
//        }
//        
//    }
//    
//    func showActivity() {
//        print(#function)
//        DispatchQueue.main.async {
//            self.view.showLoadingView()
//        }
//    }
//    
//    func hideActivity() {
//        print(#function)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//            self.view.hideLoadingView()
//        })
//    }
//}
//
//extension WeatherHomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return presenter?.numberOfItemsInSection() ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return presenter?.setCell(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return presenter?.setCellSize(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize(width: view.bounds.width, height: view.bounds.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
