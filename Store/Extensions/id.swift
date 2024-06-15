//
//  id.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

extension UITableViewCell {
    static var id: String {
        String(describing: self)
    }
}

extension UICollectionViewCell {
    static var id: String {
        String(describing: self)
    }
}
