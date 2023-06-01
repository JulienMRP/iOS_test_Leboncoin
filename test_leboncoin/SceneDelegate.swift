//
//  SceneDelegate.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController()
        let coordinator = OfferCoordinator(nav: nav)
        coordinator.start()
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}

