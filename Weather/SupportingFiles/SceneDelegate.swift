//
//  SceneDelegate.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/05.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let locationService = CoreLocationService()
        locationService.startUpdating()
        let apiManager = APIManager()

        let tabViewController = R.storyboard
                                 .main()
                                 .instantiateViewController(identifier: R.storyboard
                                                                         .main
                                                                         .mainTabViewController
                                                                         .identifier,
                                                            creator: { coder in
            return MainTabViewController(coder: coder, locationService: locationService, apiManager: apiManager)
        })
        window?.rootViewController = tabViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
