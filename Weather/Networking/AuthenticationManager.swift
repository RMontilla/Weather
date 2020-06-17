//
//  AuthenticationManager.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/17.
//  Copyright © 2020 rafael. All rights reserved.
//

import Foundation
import OAuthSwift

class AuthenticationManager {
    
    func requestAuthorization() {
        let oauthswift = OAuth2Swift(
          consumerKey:    "185091436273-n2ee0tg2s297nuev9hqsh6vpoo45ghi2.apps.googleusercontent.com",
          consumerSecret: "",        // No secret required
          authorizeUrl:   "https://accounts.google.com/o/oauth2/auth",
          accessTokenUrl: "https://accounts.google.com/o/oauth2/token",
          responseType:   "code"
        )

        oauthswift.allowMissingStateCheck = true
        //2
        //oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)

        //3
        oauthswift.authorize(withCallbackURL: "Weather://oauth-callback/google",
                             scope: "profile",
                             state: "") { result in
            switch result {
            case .success(let (credential, _, _)):
              print(credential.oauthToken)
              // Do your request
            case .failure(let error):
              print(error.localizedDescription)
            }
        }
    }
    
}
