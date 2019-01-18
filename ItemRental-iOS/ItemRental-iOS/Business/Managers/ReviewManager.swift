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
    
    private let apiURL = "http://127.0.0.1:5000/api/v1/reviews/"
    
    var reviews = [Review]()
    
    // MARK: - Functions
    
    func createReview(review: Review, completion: @escaping RequestDataCompletion) {
        let json: [String: Any] = ["text": review.text,
                                   "rating": review.rating,
                                   "owner_name": review.ownerName,
                                   "rentableitem_id": "\(review.rentableItemId)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: apiURL)!
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        process(request: request, completion: completion)
    }
    
    private func process(request: NSMutableURLRequest, completion: @escaping RequestDataCompletion) {
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("failed request 1")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("unkown")
                completion(nil, .unknown)
                return
            }
            
            guard response.statusCode == 200 else {
                print("failed request 2")
                completion(nil, .failedRequest)
                return
            }
            
            completion(data, nil)
            
            }.resume()
    }
}
