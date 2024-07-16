//
//  StoreRepository.swift
//  Store
//
//  Created by J Oh on 7/8/24.
//

import Foundation
import RealmSwift

final class ItemRepository {
    
    private let realm = try! Realm()
    
    init() {
        print("init - ItemRepository")
    }
    
    deinit {
        print("deinit - ItemRepository")
    }
    
    func printPath() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func fetchAll() -> Results<StoreModel> {
        let list = realm.objects(StoreModel.self)
        print(realm.configuration.fileURL ?? "")
        return list
    }
    
    func createItem(_ data: StoreModel) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Success")
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAllItems() {
        do {
            try realm.write {
                let allItems = realm.objects(StoreModel.self)
                realm.delete(allItems)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteItem(_ data: StoreModel) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print(error)
        }
    }
    
    func schemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version:", version)
        } catch {
            print(error)
        }
    }
    
    func likeClicked(item: SearchedItem) {
        let product = StoreModel(title: item.title,
                                 link: item.link,
                                 price: item.lprice,
                                 mallName: item.mallName,
                                 image: item.image,
                                 productId: item.productId)
        
        if let existingProduct = realm.object(ofType: StoreModel.self, forPrimaryKey: product.productId) {
            deleteItem(existingProduct)
        } else {
            createItem(product)
        }
    }
    
    func convertToModel(item: SearchedItem) -> StoreModel {
        let product = StoreModel(title: item.title,
                                 link: item.link,
                                 price: item.lprice,
                                 mallName: item.mallName,
                                 image: item.image,
                                 productId: item.productId)
        return product
    }
}



