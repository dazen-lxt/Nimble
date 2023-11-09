//
//  LoginContract.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation


protocol LoginPresentationLogic: AnyObject {
    func presentLoginResult(isSuccess: Bool)
}

protocol LoginDisplayLogic: AnyObject {
    func displayLoginSuccess()
    func displayError(error: String)
}

protocol LoginBusinessLogic: AnyObject {
    func loginUser(username: String, password: String)
}

protocol LoginWireframeLogic: AnyObject {
    func goToList()
    func presentForgotPassword()
}
