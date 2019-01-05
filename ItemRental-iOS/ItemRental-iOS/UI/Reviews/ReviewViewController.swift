//
//  ReviewsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 05/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class ReviewViewController: UIViewController {
    // MARK: - Properties
    
    private let reviewSection = UITextView()
    private let postButton = UIButton()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        view.backgroundColor = .gray
        
        setupReviewSection()
        setupPostButton()
    }
    
    private func setupReviewSection() {
        reviewSection.backgroundColor = .white
        reviewSection.isEditable = true
        reviewSection.adjustsFontForContentSizeCategory = true
        reviewSection.isSelectable = true
        reviewSection.layer.cornerRadius = 10
        reviewSection.font = UIFont.systemFont(ofSize: 20)
        
        view.addSubview(reviewSection)
        reviewSection.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
            $0.trailing.equalToSuperview().offset(-Padding.p20)
            $0.height.equalTo(Height.h100)
        }
    }
    
    private func setupPostButton() {
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = .orange
        postButton.layer.cornerRadius = 10
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        
        view.addSubview(postButton)
        postButton.snp.makeConstraints {
            $0.top.equalTo(reviewSection.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
            $0.trailing.equalToSuperview().offset(-Padding.p20)
        }
    }
    
    @objc private func postButtonTapped() {
        print("post")
    }
}
