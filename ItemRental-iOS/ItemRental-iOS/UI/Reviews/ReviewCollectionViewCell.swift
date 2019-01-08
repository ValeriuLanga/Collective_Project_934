//
//  ReviewCollectionViewCell.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 08/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class ReviewCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    let reviewSection = UITextView()
    let postedDateLabel = UILabel()
    let ratingLabel = UILabel()
    let ownerNameLabel = UILabel()
    
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
        layer.cornerRadius = 10
        
        setupOwnerName()
        setupReviewSection()
        setupRatingLabel()
        setupPostedDateLabel()
    }
    
    private func setupReviewSection() {
        reviewSection.layer.cornerRadius = 5
        reviewSection.backgroundColor = .white
        reviewSection.isEditable = false
        reviewSection.font = UIFont.systemFont(ofSize: 20)
        
        addSubview(reviewSection)
        reviewSection.snp.makeConstraints {
            $0.top.equalTo(ownerNameLabel.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p10)
            $0.trailing.equalToSuperview().offset(-Padding.p10)
        }
    }
    
    private func setupOwnerName() {
        ownerNameLabel.textAlignment = .center
        ownerNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        addSubview(ownerNameLabel)
        ownerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
    }
    
    private func setupRatingLabel() {
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(reviewSection.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p10)
            $0.bottom.equalToSuperview().offset(-Padding.p20)
        }
    }
    
    private func setupPostedDateLabel() {
        postedDateLabel.textAlignment = .right
        postedDateLabel.font = UIFont.systemFont(ofSize: 22)
        
        addSubview(postedDateLabel)
        postedDateLabel.snp.makeConstraints {
            $0.top.equalTo(reviewSection.snp.bottom).offset(Padding.p10)
            $0.trailing.equalToSuperview().offset(-Padding.p20)
            $0.bottom.trailing.equalToSuperview().offset(-Padding.p20)
        }
    }
}
