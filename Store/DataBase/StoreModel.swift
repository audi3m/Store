//
//  StoreModel.swift
//  Store
//
//  Created by J Oh on 7/8/24.
//

import Foundation
import RealmSwift

final class Mall: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var mallList: List<StoreModel>
}

final class StoreModel: Object {
    
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var price: String
    @Persisted var mallName: String
    @Persisted var image: String
    @Persisted(primaryKey: true) var productId: String
    
    @Persisted(originProperty: "mallList") var main: LinkingObjects<Mall>
    
    convenience init(title: String, link: String, price: String, mallName: String, image: String, productId: String) {
        self.init()
        self.title = title
        self.link = link
        self.price = price
        self.mallName = mallName
        self.image = image
        self.productId = productId
    }
    
    func convertToItem() -> SearchedItem {
        let item = SearchedItem(title: self.title,
                                link: self.link,
                                image: self.image,
                                lprice: self.price,
                                mallName: self.mallName,
                                productId: self.productId)
        return item
    }
}
