//
//  AuthViewController.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/17.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import GoogleSignIn
import SwiftKeychainWrapper

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension AuthViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            guard let accessToken = user.authentication.accessToken else { return }
            print("accessToken \(accessToken)")
            KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
            //User info
        }
    }
}
