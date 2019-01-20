//
//  Category.swift
//  
//
//  Created by Stefan Lupascu on 17/01/2019.
//

import Foundation

enum Category {
    case filmAndPhotography
    case projectorsAndScreens
    case drones
    case djEquipment
    case sports
    case musical
    
    var category: String {
        switch self {
        case .filmAndPhotography:
            return "Film & Photography"
        case .projectorsAndScreens:
            return "Projectors & Screens"
        case .drones:
            return "Drones"
        case .djEquipment:
            return "DJ Equipment"
        case .sports:
            return "Sports"
        case .musicalInstruments:
            return "Musical"
        }
    }
}
