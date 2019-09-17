//
//  Chalet.swift
//  Task
//
//  Created by Nervana Adel on 9/15/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import Foundation

// MARK: - APIDataResponse
struct APIDataResponse: Codable {
    let data: DataInfo?
}

// MARK: - DataInfo
struct DataInfo: Codable {
    let chalets: [Chalet]?
    let dates: [DateElement]?
    let notifications: Int?
}

// MARK: - Chalet
struct Chalet: Codable {
    let id, title, published, status: String?
    let units: [Unit]?
}

// MARK: - Unit
struct Unit: Codable {
    let id, chaletID, title, capacity: String?
    let code: String?
    let weekDays: [WeekDay]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case chaletID = "chalet_id"
        case title, capacity, code, weekDays
    }
}

// MARK: - WeekDay
struct WeekDay: Codable {
    let id, unitID, chaletID, label: String?
    let name, price, discount, pdate: String?
    let isReserved: String?
    let reservationID, type, status: String?
    let customPrice, hasOffer: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case unitID = "unit_id"
        case chaletID = "chalet_id"
        case label, name, price, discount, pdate
        case isReserved = "is_reserved"
        case reservationID = "reservation_id"
        case type, status
        case customPrice = "custom_price"
        case hasOffer = "has_offer"
    }
}

// MARK: - DateElement
struct DateElement: Codable {
    let dayLabel, date, datef, hjri: String?
    let enLabel: String?
}
