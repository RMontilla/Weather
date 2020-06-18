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
import Combine

class AuthViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    // MARK: - Variables
    private let viewModel = AuthViewModel()
    private var bag = Set<AnyCancellable>()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleSignIn()
        setupBindings()
        // Do any additional setup after loading the view.
    }

    // MARK: - Setup
    private func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }

    private func setupBindings() {
        viewModel.validCredentials
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &bag)
        /* Adding Publishers
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
            .map { $0.object as? UITextField }
            .map { $0?.text ?? "" }
            .assign(to: \.password, on: viewModel)
            .store(in: &bag)
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: usernameTextField)
            .map { $0.object as? UITextField }
            .map { $0?.text ?? "" }
            .assign(to: \.username, on: viewModel)
            .store(in: &bag)*/
    }

    // MARK: - UI Actions
    @IBAction func valueDidChange(_ sender: UITextField) {
        switch sender {
        case usernameTextField: viewModel.username = sender.text ?? ""
        case passwordTextField: viewModel.password = sender.text ?? ""
        default: break
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("loginButtonTapped")
    }
}

extension AuthViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            guard let accessToken = user.authentication.accessToken else { return }
            KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
        }
    }
}
