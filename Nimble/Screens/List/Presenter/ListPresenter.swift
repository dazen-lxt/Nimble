//
//  ListPresenter.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

final class ListPresenter {
    
    weak var view: ListDisplayLogic?
}

extension ListPresenter: ListPresentationLogic {
    
    func presentResult(items: [SurveyModel]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        let viewModel = items.map {
            SurveyViewModel(
                title: $0.title,
                description: $0.description,
                coverImageUrl: $0.coverImageUrl,
                surveyType: $0.surveyType,
                date: dateFormatter.string(from: $0.date).uppercased()
            )
        }
        view?.displayViewModels(items: viewModel)
    }
}
