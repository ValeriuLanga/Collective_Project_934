//
//  LoginViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private let userTextfield = UITextField()
    private let passwordTextfield = UITextField()
    private let loginButton = UIButton()
    private let registerButton = UIButton()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = .gray
        
        setupUserTextfield()
        setupPasswordTextfield()
        setupLoginButton()
        setupRegisterButton()
    }
    
    private func setupUserTextfield() {
        userTextfield.placeholder = "User"
        userTextfield.textAlignment = .center
        userTextfield.borderStyle = .roundedRect
        
        view.addSubview(userTextfield)
        userTextfield.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p240)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupPasswordTextfield() {
        passwordTextfield.placeholder = "Password"
        passwordTextfield.textAlignment = .center
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.borderStyle = .roundedRect
        
        view.addSubview(passwordTextfield)
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(userTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.backgroundColor = .orange
        loginButton.layer.cornerRadius = 10
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupRegisterButton() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.backgroundColor = .orange
        registerButton.layer.cornerRadius = 10
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    @objc private func loginButtonTapped() {
        print("login")
    }
    
    @objc private func registerButtonTapped() {
        let registerViewController = RegisterViewController()
        present(registerViewController, animated: true)
    }
}
