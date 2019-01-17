//
//  AddItemViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 05/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

protocol AddItemDelegate: class {
    func didAddItem()
}

final class AddItemViewController: UIViewController {
    // MARK: - Properties
    
    weak var delegate: AddItemDelegate?
    private let manager = ItemManager()
    
    private let titleTextfield = UITextField()
    private let categoryTextfield = UITextField()
    private let usageTypeTextfield = UITextField()
    private let receivingDetailsTextfield = UITextField()
    private let itemDescriptionTextfield = UITextField()
    private let startDateTextfield = UITextField()
    private let endDateTextfield = UITextField()
    private let addButton = UIButton()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
//        view.backgroundColor = .gray
        view.backgroundColor = .white
        
        setupTitleTextfield()
        setupCategoryTextfield()
        setupUsageTypeTextfield()
        setupReceivingDetailsTextfield()
        setupItemDescriptionTextfield()
        setupStartDateTextfield()
        setupEndDateTextfield()
        setupAddButton()
    }
    
    private func setupTitleTextfield() {
        titleTextfield.borderStyle = .roundedRect
        titleTextfield.placeholder = "Title"
        
        view.addSubview(titleTextfield)
        titleTextfield.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p40)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupCategoryTextfield() {
        categoryTextfield.borderStyle = .roundedRect
        categoryTextfield.placeholder = "Category"
        
        view.addSubview(categoryTextfield)
        categoryTextfield.snp.makeConstraints {
            $0.top.equalTo(titleTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupUsageTypeTextfield() {
        usageTypeTextfield.borderStyle = .roundedRect
        usageTypeTextfield.placeholder = "Usage Type"
        
        view.addSubview(usageTypeTextfield)
        usageTypeTextfield.snp.makeConstraints {
            $0.top.equalTo(categoryTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupReceivingDetailsTextfield() {
        receivingDetailsTextfield.borderStyle = .roundedRect
        receivingDetailsTextfield.placeholder = "Receiving Details"
        
        view.addSubview(receivingDetailsTextfield)
        receivingDetailsTextfield.snp.makeConstraints {
            $0.top.equalTo(usageTypeTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupItemDescriptionTextfield() {
        itemDescriptionTextfield.borderStyle = .roundedRect
        itemDescriptionTextfield.placeholder = "Item Description"
        
        view.addSubview(itemDescriptionTextfield)
        itemDescriptionTextfield.snp.makeConstraints {
            $0.top.equalTo(receivingDetailsTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupStartDateTextfield() {
        startDateTextfield.borderStyle = .roundedRect
        startDateTextfield.placeholder = "Aug 12 2013 4:20PM"
        
        view.addSubview(startDateTextfield)
        startDateTextfield.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupEndDateTextfield() {
        endDateTextfield.borderStyle = .roundedRect
        endDateTextfield.placeholder = "Aug 12 2013 4:20PM"
        
        view.addSubview(endDateTextfield)
        endDateTextfield.snp.makeConstraints {
            $0.top.equalTo(startDateTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupAddButton() {
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .orange
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.top.equalTo(endDateTextfield.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    @objc private func addButtonTapped() {        
        guard let title = titleTextfield.text,
                let category = categoryTextfield.text,
                let usageType = usageTypeTextfield.text,
                let receivingDetails = receivingDetailsTextfield.text,
                let itemDescription = itemDescriptionTextfield.text,
                let startDate = startDateTextfield.text,
                let endDate = endDateTextfield.text else {
                    return
        }

        guard title != "",
                category != "",
                usageType != "",
                receivingDetails != "",
                itemDescription != "",
                startDate != "",
                endDate != "" else {
                presentAlert(message: "All fields must be completed!")
                return
        }
        
        guard let userName = UserDefaults.standard.string(forKey: "user") else {
            return
        }
        let item = RentableItem(title: title, category: category, usageType: usageType, receivingDetails: receivingDetails, itemDescription: itemDescription, ownerName: userName, startDate: startDate, endDate: endDate, rented: false)
        
        manager.addItem(item: item) { [weak self](data, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.presentAlert(message: "Item could not be added!")
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.delegate?.didAddItem()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
