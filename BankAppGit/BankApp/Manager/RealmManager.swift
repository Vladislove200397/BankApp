//
//  RealmManager.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 25.01.23.
//

import Foundation
import RealmSwift

class RealmManager<T> where T: Object {
   private let realm = try! Realm()
    
    func write(object: T) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func read() -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func delete(object: T) {
        try? realm.write {
            realm.delete(object)
        }
    }
}
