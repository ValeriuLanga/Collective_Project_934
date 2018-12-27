//
//  RegisterViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class RegisterViewController: UIViewController {
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let nameTextfield = UITextField()
    private let passwordTextfield = UITextField()
    private let emailTextfield = UITextField()
    private let ratingTextfield = UITextField()
    private let phoneTextfield = UITextField()

    private let cityTextfield = UITextField()
    private let streetTextfield = UITextField()
    private let latitudeTextfield = UITextField()
    private let longitudeTextfield = UITextField()
    
    private let registerButton = UIButton()
    private let cancelButton = UIButton()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = .gray
        
        setupNameTextfield()
        setupPasswordTextfield()
        setupEmailTextfield()
        setupRatingTextfield()
        setupPhoneTextfield()
        setupCityTextfield()
        setupStreetTextfield()
        setupLatitudeTextfield()
        setupLongitudeTextfield()
        setupRegisterButton()
        setupCancelButton()
    }
    
    private func setupNameTextfield() {
        nameTextfield.placeholder = "User"
        nameTextfield.textAlignment = .center
        nameTextfield.borderStyle = .roundedRect
        
        view.addSubview(nameTextfield)
        nameTextfield.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupPasswordTextfield() {
        passwordTextfield.placeholder = "Password"
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.textAlignment = .center
        passwordTextfield.borderStyle = .roundedRect
        
        view.addSubview(passwordTextfield)
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(nameTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupEmailTextfield() {
        emailTextfield.placeholder = "Email"
        emailTextfield.textAlignment = .center
        emailTextfield.borderStyle = .roundedRect
        
        view.addSubview(emailTextfield)
        emailTextfield.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupRatingTextfield() {
        ratingTextfield.placeholder = "Rating"
        ratingTextfield.textAlignment = .center
        ratingTextfield.borderStyle = .roundedRect
        
        view.addSubview(ratingTextfield)
        ratingTextfield.snp.makeConstraints {
            $0.top.equalTo(emailTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupPhoneTextfield() {
        phoneTextfield.placeholder = "Phone number"
        phoneTextfield.textAlignment = .center
        phoneTextfield.borderStyle = .roundedRect
        
        view.addSubview(phoneTextfield)
        phoneTextfield.snp.makeConstraints {
            $0.top.equalTo(ratingTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupCityTextfield() {
        cityTextfield.placeholder = "City"
        cityTextfield.textAlignment = .center
        cityTextfield.borderStyle = .roundedRect
        
        view.addSubview(cityTextfield)
        cityTextfield.snp.makeConstraints {
            $0.top.equalTo(phoneTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupStreetTextfield() {
        streetTextfield.placeholder = "Street"
        streetTextfield.textAlignment = .center
        streetTextfield.borderStyle = .roundedRect
        
        view.addSubview(streetTextfield)
        streetTextfield.snp.makeConstraints {
            $0.top.equalTo(cityTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupLatitudeTextfield() {
        latitudeTextfield.placeholder = "Latitude"
        latitudeTextfield.textAlignment = .center
        latitudeTextfield.borderStyle = .roundedRect
        
        view.addSubview(latitudeTextfield)
        latitudeTextfield.snp.makeConstraints {
            $0.top.equalTo(streetTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupLongitudeTextfield() {
        longitudeTextfield.placeholder = "Latitude"
        longitudeTextfield.textAlignment = .center
        longitudeTextfield.borderStyle = .roundedRect
        
        view.addSubview(longitudeTextfield)
        longitudeTextfield.snp.makeConstraints {
            $0.top.equalTo(latitudeTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupRegisterButton() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.backgroundColor = .orange
        registerButton.layer.cornerRadius = 10
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.top.equalTo(longitudeTextfield.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.backgroundColor = .orange
        cancelButton.layer.cornerRadius = 10
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    @objc private func registerButtonTapped() {
        print("register")
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
