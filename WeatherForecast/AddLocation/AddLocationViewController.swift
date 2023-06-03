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


//
////  LocationHelperView.swift
////  MapKitExample
////
////  Created by Sohanur Rahman on 1/6/23.
////
//
//import UIKit
//import MapKit
//
//protocol LocationHelperDelegate{
//    func selectedLocation(name: String, latitude: String, longitude: String)
//}
//
//class LocationHelperView: UIView, UITextFieldDelegate {
//
//    var delegate: LocationHelperDelegate?
//
//    private var searchTextField: UITextField = {
//        let textField = UITextField()
//        textField.borderStyle = .roundedRect
//        textField.placeholder = "Search Your Desired Location"
//        textField.font = UIFont.systemFont(ofSize: 14)
//        textField.autocorrectionType = .no
//        textField.spellCheckingType = .no
//        textField.textColor = UIColor.black
//        return textField
//    }()
//
//    private var cancelButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Cancel", for: .normal)
//        button.setTitleColor(UIColor.red, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
//        return button
//    }()
//
//    private var locationTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return tableView
//    }()
//
//    var searchCompleter: MKLocalSearchCompleter?
//    var searchResults: [MKLocalSearchCompletion] = []
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        self.backgroundColor = .white
//        setUpViews()
//
//        locationTableView.dataSource = self
//        locationTableView.delegate = self
//
//        searchCompleter = MKLocalSearchCompleter()
//        searchCompleter?.delegate = self
//
//        searchCompleter?.queryFragment = "Dhaka"
//
//    }
//
//    func getSuggestion(name: String){
//
//        searchCompleter?.queryFragment = name
//
//    }
//
//
//
//
//    func setUpViews() {
//
//        self.addSubview(searchTextField)
//        searchTextField.translatesAutoresizingMaskIntoConstraints = false
//        searchTextField.delegate = self
//
//        self.addSubview(cancelButton)
//        cancelButton.translatesAutoresizingMaskIntoConstraints = false
//
//
//        self.addSubview(locationTableView)
//        locationTableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//
//
//            // Set searchTextField to superview
//            searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
//            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            searchTextField.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: 20),
//            searchTextField.widthAnchor.constraint(equalToConstant: (self.bounds.width - 120) ),
//            searchTextField.heightAnchor.constraint(equalToConstant: 40),
//
//            // Set cancelButton to superview
//            cancelButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
//            cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 20),
//            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
//            cancelButton.heightAnchor.constraint(equalToConstant: 40),
//
//            // Set locationTableView to superview
//            locationTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 5.0),
//            locationTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            locationTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
//            locationTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//
//        ])
//    }
//
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if (string == "\n") {
//            textField.resignFirstResponder()
//            if searchTextField.text!.isEmpty {
//                searchResults.removeAll()
//                locationTableView.reloadData()
//            }
//            else{
//                getSuggestion(name: searchTextField.text!)
//            }
//            return false
//        }
//
//        if let char = string.cString(using: String.Encoding.utf8) {
//            let isBackSpace = strcmp(char, "\\b")
//            if (isBackSpace == -92) {
//                var str = searchTextField.text!
//                str.removeLast()
//                if str.isEmpty {
//                    searchResults.removeAll()
//                    locationTableView.reloadData()
//                }
//                else{
//                    getSuggestion(name: str)
//                }
//            }
//            else{
//                getSuggestion(name:  searchTextField.text! + string)
//            }
//        }
//        return true
//    }
//
//
//    @objc func cancelSearch(sender: Any) {
//        self.removeFromSuperview()
//    }
//
//}
//extension LocationHelperView : UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResults.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(searchResults[indexPath.row].title), \(searchResults[indexPath.row].title)"
//        cell.textLabel?.numberOfLines = 0
//        //        locationTableView.rowHeight = 200
//        return cell
//    }
//
//    // MARK: - UITableViewDelegate
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Handle row selection
//        print("Selected item: \(searchResults[indexPath.row])")
//
//        let searchRequest = MKLocalSearch.Request(completion: searchResults[indexPath.row])
//
//        let search = MKLocalSearch(request: MKLocalSearch.Request(completion: searchResults[indexPath.row] ) )
//        search.start { (response, error) in
//            if let coordinate = response?.mapItems.first?.placemark.coordinate {
//                let latitude = coordinate.latitude
//                let longitude = coordinate.longitude
//
//                self.delegate?.selectedLocation(name: self.searchResults[indexPath.row].title + ", " +
//                                                self.searchResults[indexPath.row].subtitle, latitude: String(describing: latitude), longitude: String(describing: longitude))
//                self.removeFromSuperview()
//
//            }
//        }
//    }
//}
//
//
//extension LocationHelperView: MKLocalSearchCompleterDelegate {
//
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        searchResults = completer.results
//        locationTableView.reloadData()
//    }
//
//    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//        // Handle autocompletion error
//
//        searchResults = completer.results
//        locationTableView.reloadData()
//    }
//
//}
//
//
////        for completion in searchResults {
////
////            let searchRequest = MKLocalSearch.Request(completion: completion)
////
////            let search = MKLocalSearch(request: MKLocalSearch.Request(completion: searchResults[indexPath.row] ) )
////            search.start { (response, error) in
////                if let coordinate = response?.mapItems.first?.placemark.coordinate {
////                    let latitude = coordinate.latitude
////                    let longitude = coordinate.longitude
////
////                    //                    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=0d684dd73f98027229156f36f2b75da4") else {
////                    //                        // Handle invalid URL
////                    //                        return
////                    //                    }
////                    //
////                    //                    let session = URLSession.shared
////                    //                    let dataTask = session.dataTask(with: url) { (data, response, error) in
////                    //                        if let error = error {
////                    //                            // Handle error
////                    //                            print("Error: \(error)")
////                    //                            return
////                    //                        }
////                    //
////                    //                        guard let httpResponse = response as? HTTPURLResponse,
////                    //                              (200...299).contains(httpResponse.statusCode) else {
////                    //                            // Handle invalid response or status code
////                    //                            return
////                    //                        }
////                    //
////                    //                        if let data = data {
////                    //                            // Process the data
////                    //                            // For example, parse JSON or decode the data to your desired format
////                    //                            // You can also update your UI or perform other actions with the retrieved data
////                    //                            do {
////                    //                                let movieApiData = try JSONDecoder().decode( Welcome.self, from: data)
////                    ////                                    self.onSuccessGetData(movieData: movieApiData)
////                    //                                print("Hey Sohan We Found Movie List Of: \(movieApiData)")
////                    //                            } catch {
////                    //                                print(error)
////                    //                            }
////                    //                        }
////                    //                    }
////                    //                    dataTask.resume()
////
////                    // Use latitude and longitude as needed
////                    print("\n\n Hey Sohan Your Place is : \(completion) which ==> Latitude: \(latitude), ==> Longitude: \(longitude)")
////                }
////            }
////        }
//
//
//// Process and display the autocomplete results as needed
//// For example, you can update a table view or a collection view with the results
////        }
//
