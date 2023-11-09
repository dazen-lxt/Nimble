//
//  ListRouter.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

class ListRouter {
    
    weak var view: ListViewController?
    var dataSource: ListDataSource?
}

extension ListRouter: ListWireframeLogic {
    
    func presentDetail() {
        if let itemSelected = dataSource?.itemSelected {
            let nextViewController = DetailBuilder.viewController(id: itemSelected.id)
            nextViewController.modalPresentationStyle = .fullScreen
            view?.present(nextViewController, animated: true)
        }
    }
}

