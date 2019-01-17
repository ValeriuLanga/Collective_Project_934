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
    
    private func setupOwnerLabel() {
        ownerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        ownerLabel.textAlignment = .center
        
        addSubview(ownerLabel)
        ownerLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
}
