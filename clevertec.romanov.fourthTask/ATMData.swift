//
//  ATMData.swift
//  clevertec.romanov.fourthTask
//
//  Created by Kirill Romanov on 5.01.23.
//

import Foundation

struct ATMData: Decodable {
    let id: Int
    let area: String
    let city_type: String
    let city: String
    let address_type: String
    let address: String
    let house: String
    let install_place: String
    let work_time: String
    let gps_x: Double
    let gps_y: Double
    let install_place_full: String
    let work_time_full: String
    let ATM_type: String
    let ATM_error: String
    let currency: String
    let cash_in: String
    let ATM_printer: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case gps_x
        case gps_y
        case area
        case city_type
        case city
        case address_type
        case address
        case house
        case install_place
        case work_time
        case install_place_full
        case work_time_full
        case ATM_type
        case ATM_error
        case currency
        case cash_in
        case ATM_printer
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Int(try container.decode(String.self, forKey: .id)) ?? 0
        gps_x = Double(try container.decode(String.self, forKey: .gps_x)) ?? 0
        gps_y = Double(try container.decode(String.self, forKey: .gps_y)) ?? 0
        area = try container.decode(String.self, forKey: .area)
        city_type = try container.decode(String.self, forKey: .city_type)
        city = try container.decode(String.self, forKey: .city)
        address_type = try container.decode(String.self, forKey: .address_type)
        address = try container.decode(String.self, forKey: .address)
        house = try container.decode(String.self, forKey: .house)
        install_place = try container.decode(String.self, forKey: .install_place)
        work_time = try container.decode(String.self, forKey: .work_time)
        install_place_full = try container.decode(String.self, forKey: .area)
        work_time_full = try container.decode(String.self, forKey: .work_time_full)
        ATM_type = try container.decode(String.self, forKey: .ATM_type)
        ATM_error = try container.decode(String.self, forKey: .ATM_error)
        currency = try container.decode(String.self, forKey: .currency)
        cash_in = try container.decode(String.self, forKey: .cash_in)
        ATM_printer = try container.decode(String.self, forKey: .ATM_printer)
    }
}
