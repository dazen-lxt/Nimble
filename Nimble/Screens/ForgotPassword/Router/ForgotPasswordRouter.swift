//
//  ForgotPasswordRouter.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

class ForgotPasswordRouter {
    
    weak var view: ForgotPasswordViewController?
}

extension ForgotPasswordRouter: ForgotPasswordWireframeLogic {
    
    func goBack() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.dismiss(animated: true)
        }
    }
}
