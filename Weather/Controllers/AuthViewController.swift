//
//  AuthViewController.swift
//  Weather
//
//  Created by rafaerum on 2020/06/17.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import OAuthSwift

class AuthViewController: UIViewController {
    @IBOutlet private weak var loginButton: UIButton!
    private var oauthswift = OAuth1Swift(
        consumerKey:    "********",
        consumerSecret: "********",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func loginButtonTapped(_ sender: Any) {
        requestAuthorization()
    }

    func requestAuthorization() {
        oauthswift = OAuth1Swift(
            consumerKey:    "********",
            consumerSecret: "********",
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        // authorize
        let handle = oauthswift.authorize(
            withCallbackURL: "oauth-swift://oauth-callback/twitter") { result in
            switch result {
            case .success(let (credential, _, parameters)):
              print(credential.oauthToken)
              print(credential.oauthTokenSecret)
              print(parameters["user_id"])
              // Do your request
            case .failure(let error):
              print(error.localizedDescription)
            }
        }

        /*oauthswift.allowMissingStateCheck = false
        //2
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self,
                                                          oauthSwift: oauthswift)

        //3
        guard let rwURL = URL(string: "com.rafael.Weather:/oauth2Callback") else { return }
        print("urlaa")
        oauthswift.authorize(withCallbackURL: rwURL,
                             scope: "https://www.googleapis.com/auth/userinfo.profile",
                             state: "") { result in
            switch result {
            case .success(let (credential, _, _)):
              print(credential.oauthToken)
              // Do your request
            case .failure(let error):
              print(error.localizedDescription)
            }
        }*/
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
