//
//  DetailPresenter.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

final class DetailPresenter {
    
    weak var view: DetailDisplayLogic?
}

extension DetailPresenter: DetailPresentationLogic {
    
    func presentResult(model: DetailModel) {
        let question = model.items.first(where: { $0.type == "question" })
        var answers: [String] = []
        for item in model.items {
            if item.type == "answer" {
                answers.append(item.text)
            } else {
                if answers.count > 0 {
                    break
                }
            }
        }
        view?.displayViewModels(viewModel: DetailViewModel(title: model.title, question: question?.text ?? "", answers: answers, coverImageUrl: model.coverImageUrl))
    }
    
    func presentServerError() {
        view?.displayError(message: "Server error")
    }
}
