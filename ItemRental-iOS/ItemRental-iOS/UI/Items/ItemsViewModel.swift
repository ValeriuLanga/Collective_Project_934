//
//  ItemsViewModel.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 27/12/2018.
//  Copyright © 2018 Stefan Lupascu. All rights reserved.
//

import Foundation

protocol ItemsViewDelegate: class{
    func didUpdateItems()
}

final class ItemsViewModel {
    // MARK: - Properties
    
    var items = [RentableItem]()
    weak var delegate: ItemsViewDelegate?
    
    private let itemManager = ItemManager()
    
    init() {
        fetchItems()
    }
    
    func fetchItems() {
        items = []
        
        itemManager.getItems {(data, error) in
            guard let data = data else {
                return
            }

            self.format(data: data)
            DispatchQueue.main.async {
                self.delegate?.didUpdateItems()
            }
        }
    }
    
    private func format(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
            print("invalid response")
            return
        }
        
        guard let itemsData = json?["rentableitems"] as? [[String: AnyObject]] else {
            print("invalid response")
            return
        }
        
        itemsData.forEach { item in
            guard let category = item["category"] as? String,
                let usageType = item["usage_type"] as? String,
                let id = item["id"] as? Int,
                    let receivingDetails = item["receiving_details"] as? String,
                    let ownerName = item["owner_name"] as? String,
                    let startDate = item["start_date"] as? String,
                    let endDate = item["end_date"] as? String else {
                return
            }
    
            let itemDescription = item["item_description"] as? String
            let item = RentableItem(id: id, category: category, usageType: usageType, receivingDetails: receivingDetails, itemDescription: itemDescription ?? "", ownerName: ownerName, startDate: startDate, endDate: endDate)
        
            items.append(item)
        }
    }
}
