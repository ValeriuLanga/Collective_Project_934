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
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
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
        backgroundColor = .gray
        layer.cornerRadius = 15
        
        setupTitleLabel()
        setupOwnerLabel()
        setupImageView()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
    
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-Padding.p20)
            $0.leading.trailing.equalToSuperview().inset(Padding.p10)
            $0.bottom.equalTo(ownerLabel.snp.top).inset(-Padding.p20)
        }
    }
    
    private func setupOwnerLabel() {
        ownerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        ownerLabel.textAlignment = .center
        
        addSubview(ownerLabel)
        ownerLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.p20)
            $0.centerX.equalToSuperview()
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
