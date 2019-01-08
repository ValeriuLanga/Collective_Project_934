//
//  UserManager.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import Foundation

enum UserManagerError {
    case unknown
    case failedRequest
    case invalidResponse
}

struct UserManager {
    // MARK: - Properties
    
    typealias UserDataCompletion = (Data?, UserManagerError?) -> Void
    typealias ItemDataCompletion = (Data?, UserManagerError?) -> Void
    typealias ReviewDataCompletion = (Data?, UserManagerError?) -> Void
    
    private let apiURL = "http://127.0.0.1:5000/api/v1/users/"
    
    // MARK: - Functions
    
    func register(user: User, completion: @escaping UserDataCompletion) {
        let location: [String: Any] = ["city": user.location.city,
                                       "street": user.location.street,
                                       "coordX": user.location.latitude,
                                       "coordY": user.location.longitude
                                        ]
        let json: [String: Any] = ["name": user.name,
                                   "password": user.password,
                                   "phone": user.phone,
                                   "rating": user.rating,
                                   "email": user.email,
                                   "location": location
                                   ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: apiURL)!
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        process(request: request, completion: completion)
    }
    
    func login(user: String, password: String, completion: @escaping UserDataCompletion) {
        let json: [String: Any] = ["name": user,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: apiURL + "login")!
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        process(request: request, completion: completion)
    }
    
    private func process(request: NSMutableURLRequest, completion: @escaping UserDataCompletion) {
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("failed request 1")
                completion(nil, UserManagerError.failedRequest)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("unkown")
                completion(nil, UserManagerError.unknown)
                return
            }
            
            guard response.statusCode == 200 else {
                print("failed request 2")
                completion(nil, UserManagerError.failedRequest)
                return
            }

            completion(data, nil)
            
            }.resume()
    }
    
    func getItemsOfUser(name: String, completion: @escaping ItemDataCompletion) {
        let url = URL(string: apiURL + "rentableitems/\(name)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.didFetchItems(data: data, response: response, error: error, completion: { (data, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            })
        }.resume()
    }
    
    func getReviewsOfUser(name: String, completion: @escaping ReviewDataCompletion) {
        let url = URL(string: apiURL + "reviews/\(name)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.didFetchReviews(data: data, response: response, error: error, completion: { (data, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            })
            }.resume()
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
    
    private func didFetchReviews(data: Data?, response: URLResponse?, error: Error?, completion: ReviewDataCompletion) {
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
}
