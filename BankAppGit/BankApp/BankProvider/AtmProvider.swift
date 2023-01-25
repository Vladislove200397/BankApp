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
    
    private func loggingRequest(requestType: AtmApi, requestCodeAnswer: Int) {
        let requestType = requestType.requestDescription
        let requestTime = Date.now
        let requestTimeStamp = Int(requestTime.timeIntervalSince1970)
        let requestObject = RealmRequestHistoryModel(requestType: requestType, requestTimeStamp: requestTimeStamp, requestCodeAnswer: requestCodeAnswer)
        
        RealmManager().write(object: requestObject)
    }
    
    func getCurrency(city: String? = nil, succed: @escaping ([AtmModel]) -> Void, failure: @escaping (Error) -> Void) {
        provider.request(.getAtms(city: city)) { result in
            switch result {
                case .success(let response):
                    guard let atmInfo = try? JSONDecoder().decode([AtmModel].self, from: response.data) else { return }
                    self.loggingRequest(requestType: .getAtms(), requestCodeAnswer: response.statusCode)
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
                    self.loggingRequest(requestType: .getFilials(), requestCodeAnswer: response.statusCode)
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
                    self.loggingRequest(requestType: .getBriliant, requestCodeAnswer: response.statusCode)
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
                    self.loggingRequest(requestType: .getMetall, requestCodeAnswer: response.statusCode)
                    succed(metals)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
