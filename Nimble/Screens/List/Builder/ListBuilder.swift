//
//  ListBuilder.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

final class ListBuilder {
    
    class func viewController() -> ListViewController {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No se pudo obtener el viewContext de Core Data")
        }
        let viewController = ListViewController()
        let localRepository = LocalItemRepository(coreDataViewContext: appDelegate.persistentContainer.viewContext)
        let remoteRepository = RemoteItemRepository(apiClient: ApiClientImpl())
        let interactor = ListInteractor(localRepository: localRepository, remoteRepository: remoteRepository)
        let presenter = ListPresenter()
        let router = ListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.view = viewController
        router.view = viewController
        router.dataSource = interactor
        return viewController
    }
    
}
