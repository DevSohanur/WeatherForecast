////
////  SettingProtocol.swift
////  WeatherForecast
////
////  Created by Sohanur Rahman on 3/6/23.
////
//
//import Foundation
//
//// MARK: - View To Presenter
//protocol ViewToPresenterWeatherHomeProtocol {
//    var view: PresenterToViewWeatherHomeProtocol? {get set}
//    var interactor: PresenterToInteractorWeatherHomeProtocol? {get set}
//    var router: PresenterToRouterWeatherHomeProtocol? {get set}
//
//    func viewDidLoad()
//    func refresh()
//
//    func numberOfRowsInSection() -> Int
//    func cellForRowAt(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    func didSelectRowAt(index: Int)
//}
//
//// MARK: - Presenter To View
//protocol PresenterToViewWeatherHomeProtocol {
//    func onFetchWeatherInformationSuccess()
//    func onFetchWeatherInformationFailed(error: String)
//
//    func showActivity()
//    func hideActivity()
//}
//
//// MARK: - Presenter To Interactor
//protocol PresenterToInteractorWeatherHomeProtocol {
//    var presenter: InteractorToPresenterWeatherHomeProtocol? {get set}
//    var weather: [WeatherModel]? {get set}
//    func fetchWeatherInformation()
//}
//
//// MARK: - Interactor To Presenter
//protocol InteractorToPresenterWeatherHomeProtocol {
//    func fetchWeatherInformationSuccess(data: [WeatherResponseModel])
//    func fetchWeatherInformationFailure(error: String)
//}
//
//// MARK: - Presenter To Router
//
//protocol PresenterToRouterWeatherHomeProtocol {
//
////    var entry: WeatherHomeEntryPoint? { get }
//
//    static func createModule() -> UINavigationController?
//}
