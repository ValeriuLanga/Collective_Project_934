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
    private let photosManager = PhotosManager(cameraPlugin: CameraPlugin())
    private let collectionView: UICollectionView
    private var spinner = UIView()
    
    private let cellId = "cellId"
    
    // MARK: - Init
    
    init(viewModel: ItemsViewModel) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySpinner()

        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func displaySpinner() {
        spinner = UIView(frame: view.bounds)
        spinner.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.center = spinner.center
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.spinner.addSubview(indicator)
            self.view.addSubview(self.spinner)
        }
    }
    
    private func removeSpinner() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.removeFromSuperview()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupNavigationBar()
//        setupCollectionView()
        setupAddButton()
        setupLogoutButton()
    }
    
    private func setupNavigationBar() {
        let imageView = UIImageView(image: UIImage(named: "rentx-logo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    private func setupCollectionView() {
        collectionView.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.snp.remakeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        let addItemViewController = AddItemViewController(photosManager: photosManager)
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
        cell.imageView.image = viewModel.items[indexPath.item].image
        
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
        return CGSize(width: 182, height: 250)
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
        setupCollectionView()
        collectionView.reloadData()
        removeSpinner()
    }
}

extension ItemsViewController: ItemDetailsDelegate {
    func didRent() {
        viewModel.fetchItems()
    }
}
