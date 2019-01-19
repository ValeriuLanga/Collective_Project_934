//
//  UIView+Extensions.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 18/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 33
        layer.shadowOpacity = 0.15
    }
}
