//
//  NSMutableData+Extensions.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 18/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
