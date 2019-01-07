//
//  ItemDetailsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

// TODO: - Work in progress

final class ItemDetailsViewController: UIViewController {
    // MARK: - Properties
    
    private let scrollView = UIScrollView()
    
    private let item: RentableItem
    private let reviewManager = ReviewManager()
    
    private let ownerLabel = UILabel()
    private let categoryLabel = UILabel()
    private let usageTypeLabel = UILabel()
    private let receivingDetailsLabel = UILabel()
    private let itemDescriptionLabel = UILabel()
    private let startDateLabel = UILabel()
    private let endDateLabel = UILabel()
    
    private let rentButton = UIButton()
    private let reviewButton = UIButton()
    
    private let reviewSection = UITableView()
    private let cellId = "cellId"
    
    // MARK: - Init
    
    init(item: RentableItem) {
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
        view.backgroundColor = .gray
        
        setupScrollView()
        
        setupOwnerLabel()
        setupCategoryLabel()
        setupUsageTypeLabel()
        setupReceivingDetailsLabel()
        setupItemDescriptionLabel()
        setupStartDateLabel()
        setupEndDateLabel()
        
        setupRentButton()
        setupReviewButton()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            
        }
    }
    
    private func setupOwnerLabel() {
        ownerLabel.textAlignment = .center
        ownerLabel.font = UIFont.boldSystemFont(ofSize: 26)
        ownerLabel.text = item.ownerName
        
        view.addSubview(ownerLabel)
        ownerLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupCategoryLabel() {
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 20)
        categoryLabel.text = item.category
        
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(ownerLabel.snp.bottom).offset(Padding.p40)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupUsageTypeLabel() {
        usageTypeLabel.textAlignment = .center
        usageTypeLabel.font = UIFont.systemFont(ofSize: 20)
        usageTypeLabel.text = item.usageType
        
        view.addSubview(usageTypeLabel)
        usageTypeLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupReceivingDetailsLabel() {
        receivingDetailsLabel.textAlignment = .center
        receivingDetailsLabel.font = UIFont.systemFont(ofSize: 20)
        receivingDetailsLabel.text = item.receivingDetails
        
        view.addSubview(receivingDetailsLabel)
        receivingDetailsLabel.snp.makeConstraints {
            $0.top.equalTo(usageTypeLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupItemDescriptionLabel() {
        itemDescriptionLabel.textAlignment = .center
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 20)
        itemDescriptionLabel.text = item.itemDescription
        
        view.addSubview(itemDescriptionLabel)
        itemDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(receivingDetailsLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupStartDateLabel() {
        startDateLabel.textAlignment = .center
        startDateLabel.font = UIFont.systemFont(ofSize: 20)
        startDateLabel.text = item.startDate
        
        view.addSubview(startDateLabel)
        startDateLabel.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupEndDateLabel() {
        endDateLabel.textAlignment = .center
        endDateLabel.font = UIFont.systemFont(ofSize: 20)
        endDateLabel.text = item.endDate
        
        view.addSubview(endDateLabel)
        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupRentButton() {
        rentButton.setTitle("Rent", for: .normal)
        rentButton.backgroundColor = .orange
        rentButton.layer.cornerRadius = 10
        rentButton.addTarget(self, action: #selector(rentButtonTapped), for: .touchUpInside)
        
        view.addSubview(rentButton)
        rentButton.snp.makeConstraints {
            $0.top.equalTo(endDateLabel.snp.bottom).offset(Padding.p30)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupReviewButton() {
        reviewButton.setTitle("Review", for: .normal)
        reviewButton.backgroundColor = .orange
        reviewButton.layer.cornerRadius = 10
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        
        view.addSubview(reviewButton)
        reviewButton.snp.makeConstraints {
            $0.top.equalTo(rentButton.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    @objc private func rentButtonTapped() {
        print("rent")
    }
    
    @objc private func reviewButtonTapped() {
        let reviewViewController = ReviewViewController()
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    private func setupReviewSection() {
        reviewSection.dataSource = self
        reviewSection.alwaysBounceVertical = true
        reviewSection.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        reviewSection.backgroundColor = .blue
        
        view.addSubview(reviewSection)
        reviewSection.snp.makeConstraints {
            $0.top.equalTo(reviewButton.snp.bottom).offset(Padding.p30)
            $0.leading.equalToSuperview().offset(Padding.p20)
            $0.trailing.equalToSuperview().offset(-Padding.p20)
        }
    }
}

// MARK: - UITableViewDataSource

extension ItemDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewManager.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = reviewManager.reviews[indexPath.row].text
        return cell
    }
}
