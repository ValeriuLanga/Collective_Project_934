//
//  ReviewsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 08/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class ReviewsViewController: UIViewController {
    // MARK: - Properties
    
    private let item: RentableItem
    private let viewModel: ReviewsViewModel
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    private let cellId = "cellId"
    
    // MARK: - Init
    
    init(item: RentableItem, viewModel: ReviewsViewModel) {
        self.item = item
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
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
        
        setupAddButton()
        setupCollectionView()
    }
    
    private func setupAddButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func addButtonTapped() {
        let reviewViewController = ReviewViewController(item: item)
        reviewViewController.delegate = self
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.bottom.trailing.equalToSuperview().offset(-Padding.p20)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let review = viewModel.reviews[indexPath.item]
        
        cell.ownerNameLabel.text = review.ownerName
        cell.postedDateLabel.text = review.postedDate
        cell.reviewSection.text = review.text
        cell.ratingLabel.text = "\(review.rating)"
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - Padding.p40, height: 250)
    }
}

// MARK: - ReviewsViewDelegate

extension ReviewsViewController: ReviewsViewDelegate {
    func didUpdateReviews() {
        collectionView.reloadData()
    }
}

// MARK: - ReviewDelegate

extension ReviewsViewController: PostReviewDelegate {
    func didPost() {
        viewModel.fetchItems()
    }
}
