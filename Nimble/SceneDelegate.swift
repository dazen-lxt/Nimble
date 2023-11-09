//
//  SceneDelegate.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = ListBuilder.viewController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userShouldLogout),
            name: .userShouldLogout,
            object: nil
        )
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    @objc func userShouldLogout() {
        DispatchQueue.main.async { [weak self] in
            let viewController = LoginBuilder.viewController()
            self?.window?.rootViewController = viewController
            self?.window?.makeKeyAndVisible()
        }
    }

}

