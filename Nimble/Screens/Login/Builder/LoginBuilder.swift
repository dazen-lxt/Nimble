//
//  LoginBuilder.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

final class LoginBuilder {
    
    class func viewController() -> LoginViewController {
        let viewController = LoginViewController()
        let interactor = LoginInteractor(apiClient: ApiClientImpl())
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.view = viewController
        router.view = viewController
        return viewController
    }
    
}
