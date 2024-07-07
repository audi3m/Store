//
//  UIImage+Ex.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

extension UIImage {
    static let magnifyingglass = UIImage(systemName: "magnifyingglass")!
    static let person = UIImage(systemName: "person")!
    static let clock = UIImage(systemName: "clock")!
    static let xmark = UIImage(systemName: "xmark")!
    static let camera = UIImage(systemName: "camera.fill")!
    static let chevronRight = UIImage(systemName: "chevron.right")!
    static let personCircle = UIImage(systemName: "person.crop.circle")!
    
    static let likeTab = UIImage.likeSelected
    static let like = UIImage.likeSelected.withRenderingMode(.alwaysOriginal)
    static let unlike = UIImage.likeUnselected.withRenderingMode(.alwaysOriginal)
}

