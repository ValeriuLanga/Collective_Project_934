//
//  ItemsViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 10/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit

final class ItemsViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = .gray
    }
}
