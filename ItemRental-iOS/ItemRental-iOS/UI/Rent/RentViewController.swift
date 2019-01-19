//
//  RentViewController.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 20/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class RentViewController: UIViewController {
    // MARK: - Properties
    
    private let manager: ItemManager
    private let item: RentableItem
    weak var delegate: ItemDetailsDelegate?

    private let timeLabel = UILabel()
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private let chooseButton = UIButton()
    
    // MARK: - Init
    
    init(manager: ItemManager, item: RentableItem) {
        self.manager = manager
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupTimeLabel()
//        setupStartDatePicker()
//        setupEndDatePicker()
//        setupDoneButton()
    }
    
    private func setupTimeLabel() {
        timeLabel.text = "Please choose a valid date between: " + item.startDate + " - " + item.endDate
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupStartDatePicker() {
        startDatePicker.datePickerMode = .date
        view.addSubview(startDatePicker)
        startDatePicker.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).inset(-Padding.p40)
            $0.leading.trailing.equalToSuperview().inset(Padding.p40)
            $0.height.equalTo(70)
        }
    }
    
    private func setupEndDatePicker() {
        endDatePicker.datePickerMode = .date
        view.addSubview(endDatePicker)
        endDatePicker.snp.makeConstraints {
            $0.top.equalTo(startDatePicker.snp.bottom).offset(Padding.p20)
            $0.leading.trailing.equalToSuperview().inset(Padding.p40)
            $0.height.equalTo(70)
        }
    }
    
    private func setupDoneButton() {
        chooseButton.setTitle("Done", for: .normal)
        chooseButton.backgroundColor = .orange
        chooseButton.layer.cornerRadius = 10
        chooseButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        view.addSubview(chooseButton)
        chooseButton.snp.makeConstraints {
            $0.top.equalTo(endDatePicker.snp.bottom).offset(Padding.p40)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
//            $0.bottom.lessThanOrEqualToSuperview().inset(Padding.p20)
        }
    }
    
    @objc private func doneButtonTapped() {
        guard let itemId = item.id else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY"
        let startDate = dateFormatter.string(from: startDatePicker.date)
        let endDate = dateFormatter.string(from: endDatePicker.date)
        
        manager.rent(itemId: itemId, startDate: startDate, endDate: endDate, username: item.ownerName) { (data, error) in
            guard let _ = data else {
                return
            }
            DispatchQueue.main.async {
                self.delegate?.didRent()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
