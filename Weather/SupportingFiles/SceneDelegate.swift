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

        let locationService = LocationService()
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
        if let url = connectionOptions.urlContexts.first?.url {
            handleDeepLinkUrl(url)
        }
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
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        //first launch after install
        handleDeepLinkUrl(URLContexts.first?.url)
    }
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        //when in background mode
        handleDeepLinkUrl(userActivity.webpageURL)
    }

    @discardableResult
    func handleDeepLinkUrl(_ url: URL?) -> Bool {
        guard let url = url else { return false }
        if let scheme = url.scheme,
            scheme.localizedCaseInsensitiveCompare("com.rafael.Weather") == .orderedSame,
            let view = url.host {
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            redirect(to: view, with: parameters)
        }
        return true
    }

    private func redirect(to view: String,
                          with parameters: [String: String]) {
        switch view {
        case "forecast": navigateToForecast()
        default: break
        }
    }

    private func navigateToForecast() {
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
          return
        }
        tabBarController.selectedIndex = 1
    }
}
