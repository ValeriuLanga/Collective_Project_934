//
//  ReviewsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 05/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

protocol PostReviewDelegate: class {
    func didPost()
}

final class ReviewViewController: UIViewController {
    // MARK: - Properties
    
    weak var delegate: PostReviewDelegate?
    
    private let item: RentableItem
    private let manager = ReviewManager()
    
    private let reviewSection = UITextView()
    private let postButton = UIButton()
    
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
    
    // MARK: - Private functions
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupReviewSection()
        setupPostButton()
    }
    
    private func setupReviewSection() {
        reviewSection.backgroundColor = .white
        reviewSection.isEditable = true
        reviewSection.adjustsFontForContentSizeCategory = true
        reviewSection.isSelectable = true
        reviewSection.font = UIFont.systemFont(ofSize: 20)
        reviewSection.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        reviewSection.layer.borderWidth = 1.0
        reviewSection.layer.cornerRadius = 5
        
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
        let text = reviewSection.text!
        
        guard text != "" else {
            presentAlert(message: "Review section should contain a proper review!")
            return
        }
        
        let review = Review(text: text, rating: 0, ownerName: UserDefaults.standard.string(forKey: "user")!, rentableItemId: item.id!)
        
        manager.createReview(review: review) { [weak self](data, error) in
            guard data != nil else {
                DispatchQueue.main.async {
                    self?.presentAlert(message: "Review could not be posted!")
                }
                return
            }
            DispatchQueue.main.async {
                self?.delegate?.didPost()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
