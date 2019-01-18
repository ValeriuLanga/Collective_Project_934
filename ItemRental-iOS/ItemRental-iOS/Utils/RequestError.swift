//
//  RequestError.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 18/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Foundation

typealias RequestDataCompletion = (Data?, RequestError?) -> Void

enum RequestError {
    case unknown
    case failedRequest
    case invalidResponse
}
