//
//  ItemsViewModel.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import Foundation

final class ItemsViewModel {
    // MARK: - Properties
    
    var items = [RentableItem]()
    
    init() {
        let item1 = RentableItem(category: "tool1", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner1", startDate: "sDate1", endDate: "eDate1")
        let item2 = RentableItem(category: "tool2", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner2", startDate: "sDate1", endDate: "eDate1")
        let item3 = RentableItem(category: "tool3", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner3", startDate: "sDate1", endDate: "eDate1")
        let item4 = RentableItem(category: "tool4", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner4", startDate: "sDate1", endDate: "eDate1")
        let item5 = RentableItem(category: "tool5", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner5", startDate: "sDate1", endDate: "eDate1")
        let item6 = RentableItem(category: "tool6", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner6", startDate: "sDate1", endDate: "eDate1")
        let item7 = RentableItem(category: "tool7", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner7", startDate: "sDate1", endDate: "eDate1")
        let item8 = RentableItem(category: "tool8", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner8", startDate: "sDate1", endDate: "eDate1")
        let item9 = RentableItem(category: "tool9", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner9", startDate: "sDate1", endDate: "eDate1")
        let item10 = RentableItem(category: "tool10", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner10", startDate: "sDate1", endDate: "eDate1")
        let item11 = RentableItem(category: "tool11", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner11", startDate: "sDate1", endDate: "eDate1")
        let item12 = RentableItem(category: "tool12", usageType: "harvesting", receivingDetails: "rDetails1", itemDescription: "description1", ownerName: "owner12", startDate: "sDate1", endDate: "eDate1")
        
        items.append(contentsOf: [item1,
                                  item2,
                                  item3,
                                  item4,
                                  item5,
                                  item6,
                                  item7,
                                  item8,
                                  item9,
                                  item10,
                                  item11,
                                  item12])
    }
}
