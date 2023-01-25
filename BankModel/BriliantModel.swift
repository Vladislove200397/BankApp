//
//  BriliantModel.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 19.01.23.
//

import Foundation

struct BriliantModel: Decodable {
    var attestat: String
    var name: String
    var grani: String
    var weight: String
    var color: String
    var cost: String
    var city: String
    var filialID: String
    
    enum CodingKeys: String, CodingKey {
        case attestat = "attestat"
        case name = "name_ru"
        case grani = "grani"
        case weight = "weight"
        case color = "color"
        case cost = "cost"
        case city = "name"
        case filialID = "filial_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        attestat = try container.decode(String.self, forKey: .attestat)
        name = try container.decode(String.self, forKey: .name)

        grani = try container.decode(String.self, forKey: .grani)
        weight = try container.decode(String.self, forKey: .weight)
        color = try container.decode(String.self, forKey: .color)
        cost = try container.decode(String.self, forKey: .cost)
        city = try container.decode(String.self, forKey: .city)
        filialID = try container.decode(String.self, forKey: .filialID)
    }
    
    init(attestat: String, name: String, grani: String, weight: String, color: String, cost: String, city: String, filialID: String) {
        self.attestat = attestat
        self.name = name
        self.grani = grani
        self.weight = weight
        self.color = color
        self.cost = cost
        self.city = city
        self.filialID = filialID
    }
}

//"attestat": "0015707",
//        "name_ru": "Круглый",
//        "grani": "57",
//        "weight": "0.17",
//        "color": "4/6Б",
//        "cost": "460.00",
//        "filial_id": "2475",
//        "sap_id": "50012813",
//        "info_worktime": "Пн 09 00 18 00    |Вт 09 00 18 00    |Ср 09 00 18 00    |Чт 09 00 18 00    |Пт 09 00 18 00    |Сб 09 00 15 00    |Вс        |",
//        "street_type": "ул.",
//        "street": "Козлова",
//        "filials_text": "Центр банковских услуг 633/Операционная служба",
//        "home_number": "23а",
//        "name": "Солигорск",
//        "name_type": "г."
