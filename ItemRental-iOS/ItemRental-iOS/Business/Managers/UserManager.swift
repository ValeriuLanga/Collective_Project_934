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
    
    private let apiURL = "http://127.0.0.1:5000/api/v1/users"
    
    // MARK: - Functions
    
    func register(user: String, password: String, email: String, rating: Int, phone: String, location: Location) {
        
    }
    
    func login(user: String, password: String, completion: @escaping UserDataCompletion) {
        let json: [String: Any] = ["name": user,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: apiURL + "/login")!
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = jsonData
//        let loginParameters = "name=\(user)&password=\(password)"
//        request.httpBody = loginParameters.data(using: .utf8)
        
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
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                print("invalid response aici")
                completion(nil, nil)
                return
            }
            
            guard let message = json?["description"] as? String else {
                print("invalid response")
                completion(nil, nil)
                return
            }
            
            print(message)
            completion(data, nil)
            
            }.resume()
    }
}
