//
//  ItemsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 10/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

final class ItemsViewController: UIViewController {
    // MARK: - Properties
    
    private let viewModel: ItemsViewModel
    
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
    
    init(viewModel: ItemsViewModel) {
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
//        view.backgroundColor = .gray
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupCollectionView()
        setupAddButton()
        setupLogoutButton()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "rentx-logo")
    }
    
    private func setupCollectionView() {
        collectionView.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.bottom.trailing.equalToSuperview().offset(-Padding.p20)
        }
    }
    
    private func setupAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupLogoutButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logoutButtonTapped))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc private func addButtonTapped() {
        let addItemViewController = AddItemViewController()
        addItemViewController.delegate = self
        navigationController?.pushViewController(addItemViewController, animated: true)
    }
    
    @objc private func logoutButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension ItemsViewController: UICollectionViewDataSource {
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

extension ItemsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        let itemDetailsViewController = ItemDetailsViewController(item: item)
        itemDetailsViewController.delegate = self
        
        navigationController?.pushViewController(itemDetailsViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 250)
    }
}

// MARK: - AddItemDelegate

extension ItemsViewController: AddItemDelegate {
    func didAddItem() {
        viewModel.fetchItems()
    }
}

// MARK: - ItemsViewDelegate

extension ItemsViewController: ItemsViewDelegate {
    func didUpdateItems() {
        collectionView.reloadData()
    }
}

extension ItemsViewController: ItemDetailsDelegate {
    func didRent() {
        viewModel.fetchItems()
    }
}
