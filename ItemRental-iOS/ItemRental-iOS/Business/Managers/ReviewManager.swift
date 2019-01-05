//
//  ReviewManager.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 05/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Foundation

struct ReviewManager {
    // MARK: - Properties
    
    private let apiURL = "http://127.0.0.1:5000/api/v1/reviews"
    
    var reviews = [Review]()
    
    // MARK: - Functions
    
    mutating func populate() {
        let review1 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 0)
        let review2 = Review(postedDate: nil, text: "review2", rating: 10, ownerName: "owner2", rentableItemId: 0)
        let review3 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 1)
        let review4 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 1)
        let review5 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 1)
        let review6 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 1)
        let review7 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 1)
        let review8 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 1)
        let review9 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 1)
        let review10 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 2)
        let review11 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 2)
        let review12 = Review(postedDate: nil, text: "review1", rating: 10, ownerName: "owner1", rentableItemId: 2)
        
        reviews.append(contentsOf: [review1, review2, review3, review4, review5, review6, review7, review8, review9, review10, review11, review12])
    }
}
