//
//  RealmRequestHistoryModel.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 25.01.23.
//

import Foundation
import RealmSwift

class RealmRequestHistoryModel: Object {
    @objc dynamic var requestType = ""
    @objc dynamic var requestTimeStamp = Int()
    @objc dynamic var requestCodeAnswer = Int()

    convenience init(requestType: String, requestTimeStamp: Int, requestCodeAnswer: Int) {
        self.init()
        self.requestType = requestType
        self.requestTimeStamp = requestTimeStamp
        self.requestCodeAnswer = requestCodeAnswer
    }
}
