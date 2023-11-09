//
//  DetailContract.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation


protocol DetailPresentationLogic: AnyObject {
    func presentResult(model: DetailModel)
    func presentServerError()
}

protocol DetailDisplayLogic: AnyObject {
    func displayViewModels(viewModel: DetailViewModel)
    func displayError(message: String)
}

protocol DetailBusinessLogic: AnyObject {
    func fetchDetail()
}

protocol DetailWireframeLogic: AnyObject {
}
