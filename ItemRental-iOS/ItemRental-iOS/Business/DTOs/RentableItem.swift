//
//  RentableItem.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import UIKit

protocol RentableItemImageDelegate: class {
    func didGet(image: UIImage)
}

struct RentableItem {
    let id: Int?
    let title: String
    let category: String
    let receivingDetails: String
    let itemDescription: String
    let price: Int
    let ownerName: String
    let startDate: String
    let endDate: String
    var rented: Bool
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            delegate?.didGet(image: image)
        }
    }
    
    weak var delegate: RentableItemImageDelegate?
    
    init(id: Int? = nil,
         title: String,
         category: String,
         receivingDetails: String,
         itemDescription: String,
         price: Int,
         ownerName: String,
         startDate: String,
         endDate: String,
         rented: Bool,
         image: UIImage? = nil) {
        self.id = id
        self.title = title
        self.category = category
        self.receivingDetails = receivingDetails
        self.itemDescription = itemDescription
        self.price = price
        self.ownerName = ownerName
        self.startDate = startDate
        self.endDate = endDate
        self.rented = rented
        self.image = image
    }
}
