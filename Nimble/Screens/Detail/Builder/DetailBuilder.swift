//
//  DetailBuilder.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

final class DetailBuilder {
    
    class func viewController(id: String) -> DetailViewController {
        let viewController = DetailViewController()
        let interactor = DetailInteractor(apiClient: ApiClientImpl(), id: id)
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.view = viewController
        router.view = viewController
        return viewController
    }
    
}
