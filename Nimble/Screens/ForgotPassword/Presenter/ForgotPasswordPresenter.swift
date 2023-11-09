//
//  ForgotPasswordPresenter.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

final class ForgotPasswordPresenter {
    
    weak var view: ForgotPasswordDisplayLogic?
}

extension ForgotPasswordPresenter: ForgotPasswordPresentationLogic {
    func presentForgotPasswordResult(isSuccess: Bool, model: ForgotPasswordModel?) {
        if let message = model?.meta.message, isSuccess {
            view?.displayForgotPasswordSuccess(message: message)
        } else {
            view?.displayError(error: "Check your information")
        }
    }
}
