//
//  MallRepository.swift
//  Store
//
//  Created by J Oh on 7/8/24.
//

import Foundation
import RealmSwift

final class MallRepository {
    
    private let realm = try! Realm()
    
    func fetchAll() -> Results<Mall> {
        let list = realm.objects(Mall.self)
        print(realm.configuration.fileURL ?? "")
        return list
    }
    
    func createItem(_ data: Mall) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Success")
            }
        } catch {
            print(error)
        }
    }
    
    func deleteItem(_ data: Mall) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print(error)
        }
    }
    
}

