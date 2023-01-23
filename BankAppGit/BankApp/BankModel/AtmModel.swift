//
//  AtmModel.swift
//  ATMinfo
//
//  Created by Vlad Kulakovsky  on 12.01.23.
//

import Foundation

struct AtmModel: Decodable {
    var id: String
    var city: String
    var addressType: String
    var address: String
    var house: String
    var installPlace: String
    var latitude: String
    var longitude: String
    var workTime: String
    var atmError: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case city = "city"
        case addressType = "address_type"
        case address = "address"
        case house = "house"
        case installPlace = "install_place"
        case latitude = "gps_x"
        case longitude = "gps_y"
        case workTime = "work_time"
        case atmError = "ATM_error"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        city = try container.decode(String.self, forKey: .city)
        addressType = try container.decode(String.self, forKey: .addressType)
        address = try container.decode(String.self, forKey: .address)
        house = try container.decode(String.self, forKey: .house)
        installPlace = try container.decode(String.self, forKey: .installPlace)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
        workTime = try container.decode(String.self, forKey: .workTime)
        atmError = try container.decode(String.self, forKey: .atmError)
    }
    
    init(id: String,
         workTime: String,
         city: String,
         addressType: String,
         address: String,
         house: String,
         installPlace: String,
         latitude: String,
         longitude: String,
         atmError: String
    ) {
        self.id = id
        self.city = city
        self.addressType = addressType
        self.address = address
        self.house = house
        self.installPlace = installPlace
        self.latitude = latitude
        self.longitude = longitude
        self.workTime = workTime
        self.atmError = atmError
    }
}
