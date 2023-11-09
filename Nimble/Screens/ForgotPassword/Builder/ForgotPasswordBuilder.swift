//
//  ForgotPasswordBuilder.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

final class ForgotPasswordBuilder {
    
    class func viewController() -> ForgotPasswordViewController {
        let viewController = ForgotPasswordViewController()
        let interactor = ForgotPasswordInteractor(apiClient: ApiClientImpl())
        let presenter = ForgotPasswordPresenter()
        let router = ForgotPasswordRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.view = viewController
        router.view = viewController
        return viewController
    }
    
}
