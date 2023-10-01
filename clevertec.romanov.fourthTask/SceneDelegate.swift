//
//  SceneDelegate.swift
//  clevertec.romanov.fourthTask
//
//  Created by Kirill Romanov on 26.12.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        let viewController = ATMLocationViewController()
        let navViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navViewController
    }
}
