//
//  Drink.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/19.
//

import Foundation

struct Drink: Equatable {
    let name: String
    let priceL: Int?
    let priceXL: Int?
    let noCaffeine: Bool
    let description: String
    let category: String
}

struct DrinkData: Codable {
    let records: [Record]
    
    struct Record: Codable {
        
        let id: String
        let fields: Fields
        
        struct Fields: Codable {
            let name: String
            let priceL: Int?
            let priceXL: Int?
            let noCaffeine: String
            let description: String
            let category: String
        }
    }
}

struct DrinkCategory {
    let name: String
    var drinks: [Drink]
}

