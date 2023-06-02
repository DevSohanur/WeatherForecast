//
//  AddLocationViewController.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit

class AddLocationViewController: UIViewController {
    
    var textField = UITextField()
    
    lazy var locationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.itemSize = .zero
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureViews()
        addSubviews()
        activateConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Add Location"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func configureViews() {
        textField.placeholder = "Search your location here"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.helveticaRegularFont(ofSize: 14)
        
        
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        locationCollectionView.isUserInteractionEnabled = false
        locationCollectionView.register(LocationCollectionCell.self, forCellWithReuseIdentifier: LocationCollectionCell.identifire)
    }
    
    func addSubviews() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationCollectionView)
        locationCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            
            // currentTemparatureLocationLabel
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            // locationCollectionView
            locationCollectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            locationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            locationCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
        ])
    }
}

extension AddLocationViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionCell.identifire, for: indexPath) as! LocationCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
