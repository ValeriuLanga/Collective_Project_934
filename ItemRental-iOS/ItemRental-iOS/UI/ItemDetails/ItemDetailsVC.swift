//
//  ItemDetailsVC.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 19/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit

final class ItemDetailsVC: UIViewController {
    // MARK: - Properties
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let categoryLabel = UILabel()
    private let receivingDetailsLabel = UILabel()
    private let itemDescriptionLabel = UILabel()
    private let startDateLabel = UILabel()
    private let endDateLabel = UILabel()
    private let upwardArrow = UIImageView()
    private let downwardArrow = UIImageView()
    private let line = UIView()
    
    private let item: RentableItem
    private let viewModel: ItemsViewModel
    private let manager = ItemManager()
    
    private let cellId = "cellId"
    
    // MARK: - Init
    
    init(item: RentableItem) {
        self.item = item
        viewModel = ItemsViewModel(user: item.ownerName, photosManager: PhotosManager(cameraPlugin: CameraPlugin()))
        
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
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        setupImageView()
        setupTitleLabel()
        setupPriceLabel()
        setupCategoryLabel()
        setupReceivingDetailsLabel()
        setupItemDescriptionLabel()
        setupUpwardArrow()
        setupStartDateLabel()
        setupEndDateLabel()
        setupDownwardArrow()
        setupLine()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = item.image
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.text = item.title
    
        let blue = UIColor(red: 55/255, green: 101/255, blue: 184/255, alpha: 1)
        titleLabel.textColor = blue
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(-Padding.p20)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setupPriceLabel() {
        priceLabel.font = UIFont.boldSystemFont(ofSize: 26)
        priceLabel.text = String(describing: item.price) + " Lei"
        priceLabel.textColor = .orange
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(-Padding.p20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupCategoryLabel() {
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
        categoryLabel.text = item.category
        categoryLabel.textColor = .gray
        
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setupReceivingDetailsLabel() {
        receivingDetailsLabel.font = UIFont.systemFont(ofSize: 14)
        receivingDetailsLabel.text = item.receivingDetails
        
        view.addSubview(receivingDetailsLabel)
        receivingDetailsLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).inset(-Padding.p10)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setupItemDescriptionLabel() {
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        itemDescriptionLabel.text = item.itemDescription
        
        view.addSubview(itemDescriptionLabel)
        itemDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(receivingDetailsLabel.snp.bottom).inset(-Padding.p10)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setupUpwardArrow() {
        upwardArrow.contentMode = .scaleAspectFit
        upwardArrow.image = UIImage(named: "upArrow")
        
        view.addSubview(upwardArrow)
        upwardArrow.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionLabel.snp.bottom).inset(-20)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
    }
    
    private func setupStartDateLabel() {
        startDateLabel.font = UIFont.systemFont(ofSize: 14)
        startDateLabel.text = item.startDate
        startDateLabel.textColor = .gray
        
        view.addSubview(startDateLabel)
        startDateLabel.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionLabel.snp.bottom).inset(-25)
            $0.leading.equalTo(upwardArrow.snp.trailing).inset(-5)
        }
    }
    
    private func setupEndDateLabel() {
        endDateLabel.font = UIFont.systemFont(ofSize: 14)
        endDateLabel.text = item.endDate
        endDateLabel.textColor = .gray
        
        view.addSubview(endDateLabel)
        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionLabel.snp.bottom).inset(-25)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupDownwardArrow() {
        downwardArrow.contentMode = .scaleAspectFit
        downwardArrow.image = UIImage(named: "downArrow")
        
        view.addSubview(downwardArrow)
        downwardArrow.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionLabel.snp.bottom).inset(-20)
            $0.trailing.equalTo(endDateLabel.snp.leading).inset(-5)
            $0.height.equalTo(30)
        }
    }
    
    private func setupLine() {
        line.backgroundColor = .lightGray
        view.applyShadow()
        
        view.addSubview(line)
        line.snp.makeConstraints {
            $0.top.equalTo(startDateLabel.snp.bottom).inset(-5)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
