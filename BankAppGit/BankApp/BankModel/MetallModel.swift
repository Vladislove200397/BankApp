//
//  MetallModel.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 24.01.23.
//

import Foundation

struct MetallModel: Decodable {
    var gold10: String
    var gold20: String
    var gold50: String
    var silv10: String
    var silv20: String
    var silv50: String
    var plat10: String
    var plat20: String
    var plat50: String
    var cityType: String
    var city: String
    var streetType: String
    var street: String
    var homeNumber: String
    var filial: String

    enum CodingKeys: String, CodingKey {
        case gold10 = "ZOL_10_out"
        case gold20 = "ZOL_20_out"
        case gold50 = "ZOL_50_out"
        case silv10 = "SIL_10_out"
        case silv20 = "SIL_20_out"
        case silv50 = "SIL_50_out"
        case plat10 = "PL_10_out"
        case plat20 = "PL_20_out"
        case plat50 = "PL_50_out"
        case cityType = "name_type"
        case city = "name"
        case streetType = "street_type"
        case street = "street"
        case homeNumber = "home_number"
        case filial = "filials_text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gold10 = try container.decode(String.self, forKey: .gold10)
        gold20 = try container.decode(String.self, forKey: .gold20)
        gold50 = try container.decode(String.self, forKey: .gold50)
        silv10 = try container.decode(String.self, forKey: .silv10)
        silv20 = try container.decode(String.self, forKey: .silv20)
        silv50 = try container.decode(String.self, forKey: .silv50)
        plat10 = try container.decode(String.self, forKey: .plat10)
        plat20 = try container.decode(String.self, forKey: .plat20)
        plat50 = try container.decode(String.self, forKey: .plat50)
        cityType = try container.decode(String.self, forKey: .cityType)
        city = try container.decode(String.self, forKey: .city)
        streetType = try container.decode(String.self, forKey: .streetType)
        street = try container.decode(String.self, forKey: .street)
        homeNumber = try container.decode(String.self, forKey: .homeNumber)
        filial = try container.decode(String.self, forKey: .filial)
    }
    
    init(gold10: String, gold20: String, gold50: String,
         silv10: String, silv20: String, silv50: String,
         plat10: String, plat20: String, plat50: String,
         cityType: String, city: String, streetType: String,
         street: String, homeNumber: String, filial: String) {
        self.gold10 = gold10
        self.gold20 = gold20
        self.gold50 = gold50
        self.silv10 = silv10
        self.silv20 = silv20
        self.silv50 = silv50
        self.plat10 = plat10
        self.plat20 = plat20
        self.plat50 = plat50
        self.cityType = cityType
        self.city = city
        self.streetType = streetType
        self.street = street
        self.homeNumber = homeNumber
        self.filial = filial
    }
}
