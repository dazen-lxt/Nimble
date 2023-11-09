//
//  ForgotPasswordContract.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import Foundation


protocol ForgotPasswordPresentationLogic: AnyObject {
    func presentForgotPasswordResult(isSuccess: Bool, model: ForgotPasswordModel?)
}

protocol ForgotPasswordDisplayLogic: AnyObject {
    func displayForgotPasswordSuccess(message: String)
    func displayError(error: String)
}

protocol ForgotPasswordBusinessLogic: AnyObject {
    func sendForgotPassword(email: String)
}

protocol ForgotPasswordWireframeLogic: AnyObject {
    func goBack()
}
