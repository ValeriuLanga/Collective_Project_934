//
//  ItemManager.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import Foundation

struct ItemManager {
    // MARK: - Properties
    
    private let apiURL = "http://127.0.0.1:5000/api/v1/rentableitems/"
    
    // MARK: - Functions
    
    func rent(itemId: Int, startDate: String, endDate: String, username: String, completion: @escaping RequestDataCompletion) {
        let json: [String: Any] = ["start_date": startDate,
                                   "end_date": endDate,
                                   "user_name": username]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: apiURL + "rent/\(itemId)")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        process(request: request, completion: completion)
    }
    
    func getItems(completion: @escaping RequestDataCompletion) {
        let url = URL(string: apiURL)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.didFetchItems(data: data, response: response, error: error, completion: { (data, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            })
        }.resume()
    }
    
    func getReviewsOfItem(id: Int, completion: @escaping RequestDataCompletion) {
        let url = URL(string: apiURL + "reviews/\(id)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.didFetchItems(data: data, response: response, error: error, completion: { (data, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            })
        }.resume()
    }
    
    func addItem(item: RentableItem, completion: @escaping RequestDataCompletion) {
        let json: [String: Any] = ["title": item.title,
                                   "category": item.category,
                                   "receiving_details": item.receivingDetails,
                                   "price": item.price,
                                   "item_description": item.itemDescription,
                                   "owner_name": item.ownerName,
                                   "available_start_date": item.startDate,
                                   "available_end_date": item.endDate]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
//        let url = URL(string: apiURL + "/")!
        let url = URL(string: apiURL)!
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        process(request: request, completion: completion)
    }
    
    private func didFetchItems(data: Data?, response: URLResponse?, error: Error?, completion: RequestDataCompletion) {
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
