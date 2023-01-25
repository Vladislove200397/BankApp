//
//  AtmProvider.swift
//  ATMinfo
//
//  Created by Vlad Kulakovsky  on 12.01.23.
//

import Foundation
import Moya

final class AtmProvider {
    
    private let provider = MoyaProvider<AtmApi>(plugins: [NetworkLoggerPlugin()])

    
    func getCurrency(city: String? = nil, succed: @escaping ([AtmModel]) -> Void, failure: @escaping (Error) -> Void) {
        provider.request(.getAtms(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let atmInfo = try? JSONDecoder().decode([AtmModel].self, from: response.data) else { return }
                    succed(atmInfo)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func getFilials(city: String? = nil, succed: @escaping([FiliasModel]) -> Void, failure: @escaping (Error) -> Void) {
        provider.request(.getFilials(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let filialsInfo = try? JSONDecoder().decode([FiliasModel].self, from: response.data) else { return }
                    succed(filialsInfo)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func getBriliants(succed: @escaping([BriliantModel]) -> Void, failure: @escaping(Error) -> Void) {
        provider.request(.getBriliant) { result in
            switch result {
                    
                case .success(let response):
                    guard let briliants = try? JSONDecoder().decode([BriliantModel].self, from: response.data) else { return }
                    succed(briliants)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func getMetall(succed: @escaping([MetallModel]) -> Void, failure: ((Error) -> Void)? = nil) {

        provider.request(.getMetall) { result in
            switch result {
                case .success(let response):
                    guard let metals = try? JSONDecoder().decode([MetallModel].self, from: response.data) else { return }
                    succed(metals)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
