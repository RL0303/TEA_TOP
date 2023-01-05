//
//  Order.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/19.
//

import Foundation

struct Order {
    var orderNo: String
    var name: String
    var phone: String
    var store: String
    var date: String
    var memo: String
}

struct OrderData: Codable {
    let records: [Record]
    struct Record: Codable {
        let id: String?
        let fields: Fields
        struct Fields: Codable {
            let name: String
            let phone: String
            let store: String
            let date: String
            var memo: String?
        }
    }
}
