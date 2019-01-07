//
//  ItemManager.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import Foundation

enum ItemManagerError {
    case unknown
    case failedRequest
    case invalidResponse
}

struct ItemManager {
    // MARK: - Properties
    
    typealias ItemDataCompletion = (Data?, ItemManagerError?) -> Void
    
    private let apiURL = "http://127.0.0.1:5000/api/v1/rentableitems"
    
    // MARK: - Functions
    
    func getItems(completion: @escaping ItemDataCompletion) {
        let url = URL(string: apiURL)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.didFetchItems(data: data, response: response, error: error, completion: { (data, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            })
        }.resume()
    }
    
    func addItem(item: RentableItem, completion: @escaping ItemDataCompletion) {
        let json: [String: Any] = ["category": item.category,
                                   "usage_type": item.usageType,
                                   "receiving_details": item.receivingDetails,
                                   "item_description": item.itemDescription,
                                   "owner_name": item.ownerName,
                                   "start_date": item.startDate,
                                   "end_date": item.endDate]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: apiURL + "/")!
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        process(request: request, completion: completion)
    }
    
    private func didFetchItems(data: Data?, response: URLResponse?, error: Error?, completion: ItemDataCompletion) {
        guard error == nil else {
            print("failed request aici")
            completion(nil, .failedRequest)
            return
        }
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            print("unkown error")
            completion(nil, .unknown)
            return
        }
        
        guard response.statusCode == 200 else {
            print("failed request")
            completion(nil, .failedRequest)
            return
        }
        
        completion(data, nil)
    }
    
    private func process(request: NSMutableURLRequest, completion: @escaping ItemDataCompletion) {
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("failed request 1")
                completion(nil, ItemManagerError.failedRequest)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("unkown")
                completion(nil, ItemManagerError.unknown)
                return
            }
            
            guard response.statusCode == 200 else {
                print("failed request 2")
                completion(nil, ItemManagerError.failedRequest)
                return
            }
            
            completion(data, nil)
            
        }.resume()
    }
}
