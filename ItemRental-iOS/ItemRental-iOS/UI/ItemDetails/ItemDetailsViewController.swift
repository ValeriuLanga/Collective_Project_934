//
//  ItemDetailsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

// TODO: - Work in progress

final class ItemDetailsViewController: UIViewController {
    // MARK: - Properties
    
    private let item: RentableItem
    
    private let ownerLabel = UILabel()
    
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
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = .gray
        
        setupOwnerLabel()
    }
    
    private func setupOwnerLabel() {
        ownerLabel.textAlignment = .center
        ownerLabel.font = UIFont.boldSystemFont(ofSize: 26)
        ownerLabel.text = item.ownerName
        
        view.addSubview(ownerLabel)
        ownerLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
}
