//
//  ItemsCollectionViewCell.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class ItemsCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    let container = UIView()
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let ownerView = UIView()
    let icon = UIImageView()
    let ownerLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
//        backgroundColor = .white
        
        container.backgroundColor = .white
        
        addSubview(container)
        container.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Padding.p10)
            $0.leading.trailing.equalToSuperview().inset(Padding.p20)
        }
//        container.layer.cornerRadius = 15
        container.applyShadow()
        
        setupTitleLabel()
        setupOwnerView()
        setupIcon()
        setupOwnerLabel()
        setupImageView()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .orange
        titleLabel.textAlignment = .center
    
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p20)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        
        container.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-Padding.p20)
            $0.leading.trailing.equalToSuperview().inset(Padding.p20)
            $0.bottom.equalTo(ownerLabel.snp.top).inset(-Padding.p20)
        }
    }
    
    private func setupOwnerView() {
        container.addSubview(ownerView)
        ownerView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupIcon() {
        icon.image = UIImage(named: "icon")
        
        ownerView.addSubview(icon)
        icon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(20)
            $0.leading.equalToSuperview()
        }
    }
    
    private func setupOwnerLabel() {
        ownerLabel.font = UIFont.systemFont(ofSize: 16)
        ownerLabel.textColor = .lightGray
        ownerLabel.textAlignment = .center
        
        ownerView.addSubview(ownerLabel)
        ownerLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(icon.snp.trailing)
            $0.trailing.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

extension ItemsCollectionViewCell: RentableItemImageDelegate {
    func didGet(image: UIImage) {
        imageView.image = image
    }
}
