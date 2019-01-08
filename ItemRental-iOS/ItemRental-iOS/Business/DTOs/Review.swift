//
//  Review.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import Foundation

struct Review {
    let postedDate: String?
    let text: String
    let rating: Int
    let ownerName: String
    let rentableItemId: Int
    
    init(postedDate: String? = nil, text: String, rating: Int, ownerName: String, rentableItemId: Int) {
        self.postedDate = postedDate
        self.text = text
        self.rating = rating
        self.ownerName = ownerName
        self.rentableItemId = rentableItemId
    }
}
