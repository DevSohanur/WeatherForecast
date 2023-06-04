////
////  WeatherRouter.swift
////  WeatherForecast
////
////  Created by Sohanur Rahman on 31/5/23.
////
//
//import Foundation
//import UIKit
//
//// Object
//// Entry Point
//
//typealias EntryPoint = AnyWeatherView & UIViewController
//
//protocol AnyWeatherRouter {
//
//    var entry: EntryPoint? { get }
//
//    static func start() -> AnyWeatherRouter
//}
//
//class WeatherRouter: AnyWeatherRouter{
//
//    var entry: EntryPoint?
//
//    static func start() -> AnyWeatherRouter {
//        let router = WeatherRouter()
//
//        // Assign VIP
//        var view: AnyWeatherView = WeatherViewController()
//        var presenter: AnyWeatherPresenter = WeatherPresenter()
//        var interactor: AnyWeatherInteractor = WeatherInteractor()
//
//        view.presenter = presenter
//        interactor.presenter = presenter
//
//        presenter.router = router
//        presenter.view = view
//        presenter.interactor = interactor
//
//        router.entry = view as? EntryPoint
//
//        return router
//    }
//
//
//
//
//}
