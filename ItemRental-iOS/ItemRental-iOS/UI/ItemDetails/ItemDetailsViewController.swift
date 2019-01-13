//
//  ItemDetailsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

protocol ItemDetailsDelegate: class {
    func didRent()
}

final class ItemDetailsViewController: UIViewController {
    // MARK: - Properties
    
    weak var delegate: ItemDetailsDelegate?
    
    private let item: RentableItem
    private let viewModel: ItemsViewModel
    
    private let manager = ItemManager()
    
    private let ownerLabel = UILabel()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let usageTypeLabel = UILabel()
    private let receivingDetailsLabel = UILabel()
    private let itemDescriptionLabel = UILabel()
    private let startDateLabel = UILabel()
    private let endDateLabel = UILabel()
    
    private let rentButton = UIButton()
    private let reviewButton = UIButton()
    private let otherItemsLabel = UILabel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    private let cellId = "cellId"
    
    // MARK: - Init
    
    init(item: RentableItem) {
        self.item = item
        viewModel = ItemsViewModel(user: item.ownerName)
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
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
        
        setupOwnerLabel()
        setupTitleLabel()
        setupCategoryLabel()
        setupUsageTypeLabel()
        setupReceivingDetailsLabel()
        setupItemDescriptionLabel()
        setupStartDateLabel()
        setupEndDateLabel()
        
        setupRentButton()
        setupReviewButton()
        setupOtherItemsLabel()
        setupCollectionView()
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
    
    private func setupTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.text = item.title
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(ownerLabel.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupCategoryLabel() {
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 20)
        categoryLabel.text = item.category
        
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.p20)
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
            $0.top.equalTo(endDateLabel.snp.bottom).offset(Padding.p20)
            $0.width.equalTo(Height.h300)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupReviewButton() {
        reviewButton.setTitle("See Reviews", for: .normal)
        reviewButton.backgroundColor = .orange
        reviewButton.layer.cornerRadius = 10
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
        
        view.addSubview(reviewButton)
        reviewButton.snp.makeConstraints {
            $0.top.equalTo(rentButton.snp.bottom).offset(Padding.p10)
            $0.width.equalTo(Height.h300)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupOtherItemsLabel() {
        otherItemsLabel.text = "Other Items from this user"
        otherItemsLabel.textAlignment = .center
        otherItemsLabel.font = UIFont.boldSystemFont(ofSize: 24)
        otherItemsLabel.layer.cornerRadius = 10
        
        view.addSubview(otherItemsLabel)
        otherItemsLabel.snp.makeConstraints {
            $0.top.equalTo(reviewButton.snp.bottom).offset(Padding.p20)
            $0.width.equalTo(Height.h300)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(otherItemsLabel.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p10)
            $0.trailing.equalToSuperview().offset(-Padding.p10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func rentButtonTapped() {
        guard let itemId = item.id else {
            return
        }
        manager.rent(itemId: itemId) { (data, error) in
            guard let _ = data else {
                return
            }
            self.delegate?.didRent()
        }
        print("rent")
    }
    
    @objc private func reviewButtonTapped() {
        guard let itemId = item.id else {
            return
        }
        let viewModel = ReviewsViewModel(itemId: itemId)
        let reviewsViewController = ReviewsViewController(item: item, viewModel: viewModel)
        navigationController?.pushViewController(reviewsViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension ItemDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ItemsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.titleLabel.text = viewModel.items[indexPath.item].title
        cell.ownerLabel.text = viewModel.items[indexPath.item].ownerName
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ItemDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        let itemDetailsViewController = ItemDetailsViewController(item: item)
        
        navigationController?.pushViewController(itemDetailsViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ItemDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 180)
    }
}

// MARK: - ItemsViewDelegate

extension ItemDetailsViewController: ItemsViewDelegate {
    func didUpdateItems() {
        collectionView.reloadData()
    }
}
