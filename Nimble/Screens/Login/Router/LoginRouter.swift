//
//  LoginRouter.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

class LoginRouter {
    
    weak var view: LoginViewController?
}

extension LoginRouter: LoginWireframeLogic {
    
    func goToList() {
        DispatchQueue.main.async {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let newRootViewController = ListBuilder.viewController()
                sceneDelegate.window?.rootViewController = newRootViewController
            }
        }
    }
    
    func presentForgotPassword() {
        let nextViewController = ForgotPasswordBuilder.viewController()
        nextViewController.modalPresentationStyle = .fullScreen
        view?.present(nextViewController, animated: true)
    }
}
