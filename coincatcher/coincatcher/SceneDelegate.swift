//
//  SceneDelegate.swift
//  coincatcher
//
//  Created by Ramon Martinez on 4/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController // Setting root view controller here
        self.window = window
        window.makeKeyAndVisible()
    }
}
