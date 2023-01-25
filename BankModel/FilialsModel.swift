//
//  FilialsModel.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 17.01.23.
//

import Foundation

struct FiliasModel: Decodable {
    var id: String
    var city: String
    var filialName: String
    var nameType: String
    var streetType: String
    var street: String
    var homeNumber: String
    var phone: String
    var latitude: String
    var longitude: String
    
    enum CodingKeys: String, CodingKey {
        case id = "filial_id"
        case city = "name"
        case filialName = "filial_name"
        case nameType = "name_type"
        case streetType = "street_type"
        case street = "street"
        case homeNumber = "home_number"
        case phone = "phone_info"
        case latitude = "GPS_X"
        case longitude = "GPS_Y"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        city = try container.decode(String.self, forKey: .city)
        filialName = try container.decode(String.self, forKey: .filialName)
        nameType = try container.decode(String.self, forKey: .nameType)
        streetType = try container.decode(String.self, forKey: .streetType)
        street = try container.decode(String.self, forKey: .street)
        homeNumber = try container.decode(String.self, forKey: .homeNumber)
        phone = try container.decode(String.self, forKey: .phone)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
    }
    
    init(id: String, city: String, filialName: String, nameType: String, streetType: String, street: String, homeNumber: String, phone: String, latitude: String, longitude: String) {
        self.id = id
        self.city = city
        self.filialName = filialName
        self.nameType = nameType
        self.streetType = streetType
        self.street = street
        self.homeNumber = homeNumber
        self.phone = phone
        self.latitude = latitude
        self.longitude = longitude
    }
}

//"filial_id": "1191",
//        "sap_id": "50006659",
//        "filial_name": "Областное управление №500",
//        "name_type": "г.",
//        "name": "Минск",
//        "street_type": "пр.",
//        "street": "Дзержинского",
//        "home_number": "69/1-4",
//        "name_type_prev": null,
//        "name_prev": null,
//        "street_type_prev": "",
//        "street_prev": "",
//        "home_number_prev": "",
//        "info_text": "",
//        "info_worktime": "Пн 9 00 17 30 12 30 13 15|Вт 9 00 17 30 12 30 13 15|Ср 9 00 17 30 12 30 13 15|Чт 9 00 17 30 12 30 13 15|Пт 9 00 16 15 12 30 13 15|Сб        |Вс        |",
//        "info_bank_bik": "",
//        "info_bank_unp": "",
//        "GPS_X": "53.865133",
//        "GPS_Y": "27.487883",
//        "bel_number_schet": "BY28AKBB 3819 3821 0001 7000 0000",
//        "foreign_number_schet": "BY28AKBB 3819 3821 0001 7000 0000",
//        "phone_info": "+375 17 279-48-79",
