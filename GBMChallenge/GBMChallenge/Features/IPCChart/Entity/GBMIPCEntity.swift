//
//  GBMIPCEntity.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 14/07/21.
//

import Foundation

/// Estructura para almacenar el IPC
struct GBMIPCEntity : Codable {
    let date : String?
    let price : Double?
    let percentageChange : Double?
    let volume : Int?
    let change : Double?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case price = "price"
        case percentageChange = "percentageChange"
        case volume = "volume"
        case change = "change"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        percentageChange = try values.decodeIfPresent(Double.self, forKey: .percentageChange)
        volume = try values.decodeIfPresent(Int.self, forKey: .volume)
        change = try values.decodeIfPresent(Double.self, forKey: .change)
    }
}
