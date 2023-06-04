//
//  SettingsVC.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit

class SettingsVC: UIViewController {
    
    var presenter: (ViewToPresenterSettingProtocol &
                    InteractorToPresenterSettingProtocol)?
    
    var scrollView = UIScrollView(frame: .zero)
    var contentView = UIView()
    
    lazy var temparatureLabel = UILabel()
    lazy var temparatureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.itemSize = .zero
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var defaultLocationLabel = UILabel()
    lazy var defaultLocationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.itemSize = .zero
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        presenter?.viewDidLoad()
    }
    
    func initView(){
        self.view.backgroundColor = UIColor.viewBackgroundColor
        
        temparatureLabel.text = "Temparature Unit"
        temparatureLabel.textColor = UIColor.titleColor
        temparatureLabel.font = UIFont.robotoSemiBoldFont(ofSize: 16)
        
        temparatureCollectionView.dataSource = self
        temparatureCollectionView.delegate = self
        temparatureCollectionView.layer.cornerRadius = 10
        temparatureCollectionView.register(SettingCollectionCell.self, forCellWithReuseIdentifier: SettingCollectionCell.identifire)
        
        defaultLocationLabel.text = "Default Location "
        defaultLocationLabel.textColor = UIColor.titleColor
        defaultLocationLabel.font = UIFont.robotoSemiBoldFont(ofSize: 16)
        
        defaultLocationCollectionView.dataSource = self
        defaultLocationCollectionView.delegate = self
        defaultLocationCollectionView.layer.cornerRadius = 10
        defaultLocationCollectionView.register(SettingCollectionCell.self, forCellWithReuseIdentifier: SettingCollectionCell.identifire)
        
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(temparatureLabel)
        temparatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(temparatureCollectionView)
        temparatureCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(defaultLocationLabel)
        defaultLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(defaultLocationCollectionView)
        defaultLocationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000),
            
            temparatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            temparatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            temparatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            temparatureLabel.heightAnchor.constraint(equalToConstant: 30),
            
            temparatureCollectionView.topAnchor.constraint(equalTo: temparatureLabel.bottomAnchor, constant: 10),
            temparatureCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            temparatureCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            temparatureCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            defaultLocationLabel.topAnchor.constraint(equalTo: temparatureCollectionView.bottomAnchor, constant: 10),
            defaultLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            defaultLocationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            defaultLocationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            defaultLocationCollectionView.topAnchor.constraint(equalTo: defaultLocationLabel.bottomAnchor, constant: 10),
            defaultLocationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            defaultLocationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            defaultLocationCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Settings"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension SettingsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == temparatureCollectionView{
            return presenter?.temparatureNumberOfItemsInSection() ?? 0
        }
        else{
            return presenter?.locationNumberOfItemsInSection() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == temparatureCollectionView{
            return presenter?.temparatureCellForItemAt(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
        }
        else{
            return presenter?.locationCellForItemAt(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == temparatureCollectionView{
            presenter?.temparatureDidSelectItemAt(collectionView, didSelectItemAt: indexPath)
        }
        else{
            presenter?.locationDidSelectItemAt(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter?.sizeForItemAt(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize(width: view.bounds.width - 40, height: 51)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension SettingsVC: PresenterToViewSettingProtocol {
    
    func onFetchLocationSuccess(data: [String]) {
        DispatchQueue.main.async { [self] in
            self.defaultLocationCollectionView.reloadData()
            let height = self.defaultLocationCollectionView.collectionViewLayout.collectionViewContentSize.height
            
            self.defaultLocationCollectionView.heightAnchor.constraint(equalToConstant: (height - 1)).isActive = true
            self.view.layoutIfNeeded()
            
            let defaultValue = UserDefaults.getStringData(key: UserDefaults.ConstantDefaultLocation)
            var index = 0
            for i in 0...data.count-1 {
                if data[i] == defaultValue{
                    index = i
                }
            }
            
            setDefaultLocation(row: index)
        }
    }
    
    func setDefaultLocation(row: Int) {
        DispatchQueue.main.async {
            self.defaultLocationCollectionView.performBatchUpdates(nil) { _ in
                self.defaultLocationCollectionView.selectItem(at: IndexPath(item: row, section: 0), animated: false, scrollPosition: [.centeredHorizontally])
                self.collectionView(self.defaultLocationCollectionView, didSelectItemAt : IndexPath(item: row, section: 0))
            }
        }
    }
    
    func setDefaultTemparature(row: Int) {
        DispatchQueue.main.async {
            self.temparatureCollectionView.performBatchUpdates(nil) { _ in
                self.temparatureCollectionView.selectItem(at: IndexPath(item: row, section: 0), animated: false, scrollPosition: [.centeredHorizontally])
                self.collectionView(self.temparatureCollectionView, didSelectItemAt : IndexPath(item: row, section: 0))
            }
        }
    }
    
    func onFetchTemparatureUnitSuccess(data: [String]) {
        DispatchQueue.main.async { [self] in
            self.temparatureCollectionView.reloadData()
            
            let defaultValue = UserDefaults.getStringData(key: UserDefaults.ConstantTemparatureUserDefaultsKey)
            var index = 0
            for i in 0...data.count-1 {
                if data[i] == defaultValue{
                    index = i
                }
            }
            
            setDefaultTemparature(row: index)
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
        DispatchQueue.main.async {
            self.view.hideLoadingView()
        }
    }
}
