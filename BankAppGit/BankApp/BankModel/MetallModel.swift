//
//  MetallModel.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 24.01.23.
//

import Foundation

struct MetallModel: Decodable {
    var metall10: String?
    var metall20: String?
    var metall50: String?

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
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch metalType {
            case .gold:
                metall10 = try container.decode(String.self, forKey: .gold10)
                metall20 = try container.decode(String.self, forKey: .gold20)
                metall50 = try container.decode(String.self, forKey: .gold50)
            case .silver:
                metall10 = try container.decode(String.self, forKey: .silv10)
                metall20 = try container.decode(String.self, forKey: .silv20)
                metall50 = try container.decode(String.self, forKey: .silv50)
            case .platinum:
                metall10 = try container.decode(String.self, forKey: .plat10)
                metall20 = try container.decode(String.self, forKey: .plat20)
                metall50 = try container.decode(String.self, forKey: .plat50)
        }
    }
    
    init(metall10: String? = nil, metall20: String? = nil, metall50: String? = nil) {
        self.metall10 = metall10
        self.metall20 = metall20
        self.metall50 = metall50
    }
}

var metalType = MetalType.platinum
