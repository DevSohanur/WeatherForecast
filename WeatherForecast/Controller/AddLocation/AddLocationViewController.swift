//
//  AddLocationViewController.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, MKLocalSearchCompleterDelegate, UITextFieldDelegate {
    
    
    var searchTextField = UITextField()
    
    lazy var locationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.itemSize = .zero
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var searchCompleter: MKLocalSearchCompleter?
    var searchResults: [MKLocalSearchCompletion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.viewBackgroundColor
        
        configureViews()
        addSubviews()
        activateConstraint()
        
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
        
        searchCompleter?.queryFragment = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.navigationBarColor
        self.navigationItem.title = "Add Location"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            if searchTextField.text!.isEmpty {
                searchResults.removeAll()
                locationCollectionView.reloadData()
            }
            else{
                getSuggestion(name: searchTextField.text!)
            }
            return false
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                var str = searchTextField.text!
                str.removeLast()
                if str.isEmpty {
                    searchResults.removeAll()
                    locationCollectionView.reloadData()
                }
                else{
                    getSuggestion(name: str)
                }
            }
            else{
                getSuggestion(name:  searchTextField.text! + string)
            }
        }
        return true
    }
    
    func getSuggestion(name: String){
        searchCompleter?.queryFragment = name
    }
    
    func configureViews() {
        searchTextField.delegate = self
        searchTextField.backgroundColor = .white
        searchTextField.spellCheckingType = .no
        searchTextField.placeholder = "Search for location here"
        searchTextField.borderStyle = .none
        
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.masksToBounds = true
        
        searchTextField.textColor = .titleColor
        searchTextField.font = UIFont.poppinsRegularFont(ofSize: 14)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTextField.bounds.height))
        searchTextField.leftView = paddingView
        searchTextField.rightView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .always
        
        searchTextField.becomeFirstResponder()
        
        
        locationCollectionView.layer.cornerRadius = 10
        locationCollectionView.layer.masksToBounds = true
        
        locationCollectionView.backgroundColor = .white
        
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        locationCollectionView.register(LocationCollectionCell.self, forCellWithReuseIdentifier: LocationCollectionCell.identifire)
    }
    
    func addSubviews() {
        view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationCollectionView)
        locationCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            
            // currentTemparatureLocationLabel
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // locationCollectionView
            locationCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            locationCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            locationCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
        ])
    }
}

extension AddLocationViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionCell.identifire, for: indexPath) as! LocationCollectionCell
        cell.locationNameLabel.text = searchResults[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let search = MKLocalSearch(request: MKLocalSearch.Request(completion: searchResults[indexPath.row] ) )
        search.start { (response, error) in
            if let coordinate = response?.mapItems.first?.placemark.coordinate {
                let latitude = coordinate.latitude
                let longitude = coordinate.longitude
                let title = self.searchResults[indexPath.row].title
                
                self.askToAddAddress(data: LocationModel(name: title, latitude: latitude, longitude: longitude))
                print("Add Location Using : \(title) \(latitude) \(longitude)")
            }
        }
    }
    
    func askToAddAddress(data : LocationModel) {
        let alert = UIAlertController(title: "Are you sure?", message: "You are going to add a new address", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))

        alert.addAction(UIAlertAction(title: "Continue", style: .default) { (action) in
            if UserDefaults.storeLocationData(data: data) {
                self.navigationController?.popViewController(animated: true)
            }
            else{
                self.showAlert(title: "Failed", message: "Same location already exist user preference.")
            }
        })
        
        self.present(alert, animated: true)
    }
}

extension AddLocationViewController {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async { [self] in
            searchResults = completer.results
            locationCollectionView.reloadData()
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle autocompletion error
        DispatchQueue.main.async { [self] in
            searchResults = completer.results
            locationCollectionView.reloadData()
        }
    }
}
