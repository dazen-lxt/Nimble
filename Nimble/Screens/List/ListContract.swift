//
//  ListContract.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation


protocol ListPresentationLogic: AnyObject {
    func presentResult(items: [SurveyModel])
}

protocol ListDisplayLogic: AnyObject {
    func displayViewModels(items: [SurveyViewModel])
}

protocol ListBusinessLogic: AnyObject {
    func fetchList()
    func selectModel(index: Int)
}

protocol ListWireframeLogic: AnyObject {
    func presentDetail()
}

protocol ListDataSource {
    var itemSelected: SurveyModel? { get }
}
