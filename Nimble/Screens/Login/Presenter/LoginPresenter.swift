//
//  LoginPresenter.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation

final class LoginPresenter {
    
    weak var view: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {
    
    func presentLoginResult(isSuccess: Bool) {
        if isSuccess {
            view?.displayLoginSuccess()
        } else {
            view?.displayError(error: "Invalid credentials")
        }
    }
}
