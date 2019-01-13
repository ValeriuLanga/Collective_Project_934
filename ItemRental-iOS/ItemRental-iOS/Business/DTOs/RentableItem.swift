//
//  RentableItem.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import Foundation

struct RentableItem {
    let id: Int?
    let title: String
    let category: String
    let usageType: String
    let receivingDetails: String
    let itemDescription: String
    let ownerName: String
    let startDate: String
    let endDate: String
    var rented: Bool
    
    init(id: Int? = nil,
         title: String,
         category: String,
         usageType: String,
         receivingDetails: String,
         itemDescription: String,
         ownerName: String,
         startDate: String,
         endDate: String,
         rented: Bool) {
        self.id = id
        self.title = title
        self.category = category
        self.usageType = usageType
        self.receivingDetails = receivingDetails
        self.itemDescription = itemDescription
        self.ownerName = ownerName
        self.startDate = startDate
        self.endDate = endDate
        self.rented = rented
    }
}
