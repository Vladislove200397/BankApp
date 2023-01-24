//
//  AtmApi.swift
//  ATMinfo
//
//  Created by Vlad Kulakovsky  on 12.01.23.
//

import Foundation
import Moya
 
enum AtmApi {
    case getAtms(city: String? = nil)
    case getFilials(city: String? = nil)
    case getBriliant
    case getMetall
}

extension AtmApi: TargetType {
    var baseURL: URL {
        switch self {
            case .getAtms:       return URL(string: "https://belarusbank.by/api/atm")!
            case .getFilials:    return URL(string: "https://belarusbank.by/api/filials_info")!
            case .getBriliant:   return URL(string: "https://belarusbank.by/api/getgems")!
            case .getMetall:    return URL(string: "https://belarusbank.by/api/getinfodrall")!
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        switch self {
            case .getAtms(city: let city):
                params["city"] = city
            case .getFilials(city: let city):
                params["city"] = city
            case .getBriliant:
                return nil
            case .getMetall:
                return nil
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
}

