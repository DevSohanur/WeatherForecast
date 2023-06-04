//
//  SettingRouter.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import UIKit

class SettingRouter: PresenterToRouterSettingProtocol{
    
    static func createModule() -> UIViewController? {
        
        let viewController = SettingsVC()

        let presenter: ViewToPresenterSettingProtocol & InteractorToPresenterSettingProtocol = SettingPresenter()

        viewController.presenter = presenter
        viewController.presenter?.router = SettingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SettingInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
