//
//  ReviewViewModel.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 08/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Foundation

protocol ReviewsViewDelegate: class {
    func didUpdateReviews()
}

final class ReviewsViewModel {
    // MARK: - Properties
    
    var reviews = [Review]()
    weak var delegate: ReviewsViewDelegate?
    
    private let itemId: Int
    private let manager = ItemManager()
    
    // MARK: - Init
    
    init(itemId: Int) {
        self.itemId = itemId
        
        fetchItems()
    }
    
    func fetchItems() {
        reviews = []
        
        manager.getReviewsOfItem(id: itemId) { (data, error) in
            guard let data = data else {
                return
            }
            self.format(data: data)
            DispatchQueue.main.async {
                self.delegate?.didUpdateReviews()
            }
        }
    }
    
    private func format(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
            print("invalid response")
            return
        }
        
        guard let reviewsData = json?["reviewitems"] as? [[String: AnyObject]] else {
            print("invalid response")
            return
        }
        
        reviewsData.forEach { review in
            guard let text = review["text"] as? String,
                let ownerName = review["owner_name"] as? String,
                let postedDate = review["posted_date"] as? String,
                let rating = review["rating"] as? Int else {
                    return
            }
    
            let review = Review(postedDate: postedDate, text: text, rating: rating, ownerName: ownerName, rentableItemId: itemId)
            
            reviews.append(review)
        }
    }
}
